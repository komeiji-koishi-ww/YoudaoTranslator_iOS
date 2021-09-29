//
//  LanguageSelector.swift
//  YoudaoTranslator
//
//  Created by kijin_seija on 2021/9/29.
//

import SwiftUI
import PartialSheet

struct LanguageSeletor: View {
    
    @ObservedObject var model : SelectorModel
    
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    @State var present : Bool = false
    
    var body: some View {
        
        VStack (spacing:0){
            SelectorView(selected: model.selectedFrom)
                .onTapGesture {
                    self.partialSheetManager.showPartialSheet {
                        
                    } content: {
                        SelectorListView(model: model, list: model.languageSelecorList.from,isFrom: true)
                    }
                    
                }
            Image("exchange")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .onTapGesture {
                    model.exchange()
                }
            SelectorView(selected: model.selectedTo)
                .onTapGesture {
                    self.partialSheetManager.showPartialSheet {
                        
                    } content: {
                        SelectorListView(model: model, list: model.languageSelecorList.to,isFrom: false)
                    }
                    
                }
        }
    }
}

struct SelectorView: View {
    
    var selected : SelectorModel.SelectorOptions
    
    var body: some View {
        HStack (alignment: .top){
            Text(selected.selectName)
            //                Spacer()
        }
        .frame(maxWidth:.infinity)
        .padding()
        .background(Color(UIColor.init(rgb: 0xF2F2F6)))
        .cornerRadius(15)
    }
}

struct SelectorListView : View {
    
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    @ObservedObject var model : SelectorModel
    var list : [SelectorModel.SelectorOptions]
    var isFrom : Bool = true
    
    var body: some View {
        List {
            ForEach (list.indices) { index in
                Text(list[index].selectName)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundColor(list[index].selected ? Color.accentColor : Color.black)
                    .onTapGesture {
                        var options = isFrom ? model.languageSelecorList.from[index] : model.languageSelecorList.to[index]
                        model.selectFromLanguage(options:&options, isFrom: isFrom)
                        partialSheetManager.closePartialSheet()
                    }
            }
        }
    }
}

struct LanguageSeletor_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSeletor(model: SelectorModel())
    }
}
