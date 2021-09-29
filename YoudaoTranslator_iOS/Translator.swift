//
//  Translator.swift
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

import UIKit
import CryptoSwift
import SwiftyJSON
import NaturalLanguage
import YTKNetwork

class Translator: ObservableObject {
    
    @Published var translated: String = ""
    var from : String = ""
    var to : String = ""
    typealias translateCallBack = (String)->Void
    var callBack : translateCallBack!
    
    var slicing = [String]()
    
    func requestWithText(text: String) {
        self.slicing.removeAll()
        translated = ""
        
        if text.count == 0 {
            return
        } else if text.count < 5000 {
            self.slicing.append(text as String)
            self.createRequests()
        }else {
            self.processText(text: text as String) {
                self.createRequests()
            }
        }
    }
    
    fileprivate func processText(text: String, callBack:()->Void) {
        
        var paragraphArr = [String]()
        
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        tagger.string = text
        let range = NSRange(location:0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitWords]
        tagger.enumerateTags(in: range, unit: .paragraph, scheme: .nameType, options: options) { tag, tokenRange, stop in
            let paragraph = (text as NSString).substring(with: tokenRange)
            paragraphArr.append(paragraph)
        }
        
        self.breakup(paragraphArr: paragraphArr, maxLength: 5000, index: 0)
        callBack()
    }
    
    fileprivate func breakup(paragraphArr: [String], maxLength: Int, index: Int) {
        
        var counter : Int = 0
        var index : Int = index
        var slicingText : String = ""
        
        while index <= paragraphArr.count-1 {
            let tempCounter = counter + paragraphArr[index].count
            if (tempCounter < maxLength){
                
                if (index == paragraphArr.count-1){
                    slicingText.append(paragraphArr[index])
                    slicing.append(slicingText)
                    return
                }
                slicingText.append(paragraphArr[index])
                counter += paragraphArr[index].count
                index += 1
            }else {
                slicing.append(slicingText)
                breakup(paragraphArr: paragraphArr, maxLength: maxLength, index: index)
                return
            }
        }
    }
    
    fileprivate func createRequests() {
        
        var requests = [PostRequest]()
        
        for slicingText in self.slicing {
            let request = PostRequest(url: "https://fanyi.youdao.com/translate_o?smartresult=dict&smartresult=rule", param: self.formData(content: slicingText as NSString))
            requests.append(request)
        }
        
        YTKBatchRequest(request: requests).startWithCompletionBlock { requests in
            for request in requests.requestArray {
                if let data = request.responseData {
                    self.processData(data: data)
                }
            }
        } failure: { failure in
        }
        
    }
    
    fileprivate func processData(data: Data) {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {return}
        let obj = JSON(json)
        
        var slicingText = String()
        
        for p in obj["translateResult"].arrayValue {
            for dic in p.arrayValue {
                if dic["tgt"].stringValue == "" {
                    slicingText.append("\n\n")
                }else {
                    let translated = dic["tgt"].stringValue
                    slicingText.append(translated)
                }
            }
        }
        
        translated.append(slicingText)
    }
    
    fileprivate func formData(content: NSString) -> [String : Any] {
        
        let user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36 Edg/94.0.992.31"
        
        let randomInt = Int.random(in: 0...10)
        
        let lts = String(format: "%0.f", NSDate().timeIntervalSince1970*1000)
        let salt = lts+String(randomInt)
        
        let sign = ("fanyideskweb" + (content as String) + salt + "Y2FYu%TNSbMCxc3t2u^XT").md5()
        
        let bv = user_agent.md5()
        
        let from = self.from
        let to = self.to
        
        return [
            "i": content,
            "from": from,
            "to": to,
            "smartresult": "dict",
            "client": "fanyideskweb",
            "salt": salt,
            "sign": sign,
            "lts": lts,
            "bv": bv,
            "doctype": "json",
            "version": "2.1",
            "keyfrom": "fanyi.web",
            "action": "FY_BY_REALTlME"
        ]
    }
    
}
