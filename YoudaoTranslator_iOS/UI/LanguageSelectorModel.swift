//
//  LanguageSelectorModel.swift
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

import Foundation
import SwiftUI

class SelectorModel : ObservableObject {
    
    struct SelectorOptions : Identifiable {
        var id = UUID()
        var selectName : String
        var lanCode : String
        var selected: Bool
    }
    
    struct SelectorList : Identifiable {
        var id = UUID()
        var from : [SelectorOptions]
        var to : [SelectorOptions]
    }
    
    @Published var selectedFrom : SelectorOptions!
    @Published var selectedTo : SelectorOptions!
    
    @Published var languageSelecorList = SelectorList(from: [
        SelectorOptions(selectName: "自动检测", lanCode: "AUTO", selected: true),
        SelectorOptions(selectName: "中文", lanCode: "zh-CHS", selected: false),
        SelectorOptions(selectName: "英文", lanCode: "en", selected: false),
        SelectorOptions(selectName: "日文", lanCode: "ja", selected: false),
        SelectorOptions(selectName: "韩文", lanCode: "ko", selected: false),
    ], to: [
        SelectorOptions(selectName: "中文", lanCode: "zh-CHS", selected: true),
        SelectorOptions(selectName: "英文", lanCode: "en", selected: false),
        SelectorOptions(selectName: "日文", lanCode: "ja", selected: false),
        SelectorOptions(selectName: "韩文", lanCode: "ko", selected: false),
    ])
    
    init() {
        self.selectedFrom = languageSelecorList.from.first
        self.selectedTo = languageSelecorList.to.first
    }
    
    func selectFromLanguage(options: inout SelectorOptions, isFrom: Bool) {
        
        for index in isFrom ? languageSelecorList.from.indices : languageSelecorList.to.indices {
            if isFrom {
                if options.lanCode == self.selectedFrom.lanCode {
                    return
                }else if options.lanCode == self.selectedTo.lanCode {
                    return
                }
                languageSelecorList.from[index].selected = false
               if options.lanCode == languageSelecorList.from[index].lanCode {
                   languageSelecorList.from[index].selected = true
                   self.selectedFrom = languageSelecorList.from[index]
               }
            }else {
                if options.lanCode == self.selectedFrom.lanCode {
                    return
                }
                languageSelecorList.to[index].selected = false
                if options.lanCode == languageSelecorList.to[index].lanCode {
                    languageSelecorList.to[index].selected = true
                    self.selectedTo = languageSelecorList.to[index]
                 }
            }
        }
    }
    
    func exchange() {
        if self.selectedFrom.lanCode == "AUTO" {
            return
        }
        (self.selectedFrom, self.selectedTo) = (self.selectedTo, selectedFrom)
    }
    
}
