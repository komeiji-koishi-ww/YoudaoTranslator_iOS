//
//  TranslateUI.swift
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

import SwiftUI
import TextView
import BottomSheet
import PartialSheet

struct Translate: View {
    
    @ObservedObject var translator : Translator = Translator()
    @ObservedObject var languageSelectorModel : SelectorModel = SelectorModel()
    
    @State var textViewInput : String = ""
    @State var isEditing : Bool = false
    
    @State var present: Bool = false
    
    var body: some View {
        VStack {
            
            LanguageSeletor(model: languageSelectorModel)
                .padding()
            
            TextView(text: $textViewInput,
                     isEditing: $isEditing,
                     placeholder: "请输入...",
                     font: UIFont.systemFont(ofSize: 22, weight: .medium),
                     textColor: UIColor.gray
            )
                .padding()
            
            Button {
                hideKeyboard()
                translator.from = languageSelectorModel.selectedFrom.lanCode
                translator.to = languageSelectorModel.selectedTo.lanCode
                
//                let path = Bundle.main.path(forResource: "File", ofType: "txt")
//                let fileContent = try?  NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)

//                translator.requestWithText(text: (fileContent ?? "") as String)
                translator.requestWithText(text: textViewInput)
                present.toggle()
            } label: {
                Text("翻译内容")
                    .frame(maxWidth: .infinity,
                           maxHeight: 50
                    )
                    .foregroundColor(Color.gray)
                    .background(Color(UIColor.init(rgb: 0xF2F2F6)))
                    .cornerRadius(15)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }

        }
        .bottomSheet(isPresented: $present, height: UIScreen.main.bounds.size.height * 0.9) {
            TranslateResult(translator: translator)
        }
        .addPartialSheet(style: .defaultStyle())
    }
    
}

struct TranslateResult : View {
    
    @ObservedObject var translator : Translator
    @State var isEditing : Bool = false
    
    var body: some View {
        TextView(text: $translator.translated,
                 isEditing: $isEditing,
                 placeholder: "....",
                 font: UIFont.systemFont(ofSize: 22, weight: .medium), isEditable: false,
                 isSelectable: true
        )
        .padding()
    }
}

struct Translate_Previews: PreviewProvider {
    static var previews: some View {
        Translate()
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
