//
//  ChangeLanguageView.swift
//  WordsApp
//
//  Created by Felipe Girardi on 14/01/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI

struct ChangeLanguageView: View {
    @EnvironmentObject var userData: UserData
    @Binding var showingChosenLanguages: Bool
    @State var langState: Int
    
    var chosenLanguages: [Language] {
        self.userData.languages.filter { $0.isChosen }
    }
    
    var cancelButton: some View {
        Button(action: {
            self.showingChosenLanguages.toggle()
        }, label: {
            Text("Sair")
                .font(.system(size: 20))
        })
    }
    
    init(showingChosenLanguages: Binding<Bool>, langState: State<Int>) {
        UITableView.appearance().separatorStyle = .none
        self._showingChosenLanguages = showingChosenLanguages
        self._langState = langState
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Selecione uma língua:")
                    .font(Font.custom("Georgia", size: 25))
                    .fontWeight(.medium)
                    .padding(.top, 100)
                    .padding(.bottom, 50)
                
                List {
                    ForEach(self.chosenLanguages, id: \.self) { chosenLang in
                        Button(action: {
                            self.langState = chosenLang.id
                        }) {
                            chosenLang.id == self.langState ? ChangeLanguageButton(langName: chosenLang.name, langFlag: chosenLang.flag, bgColor: Color(red: 255/255, green: 215/255, blue: 0/255), borderColor: Color(red: 50/255, green: 50/255, blue: 255/255), borderWidth: 3) : ChangeLanguageButton(langName: chosenLang.name, langFlag: chosenLang.flag, bgColor: Color(.clear), borderColor: Color(.black), borderWidth: 1)
                        }
                        
                    }
                }
                
                Button(action: {
                    self.userData.currentLanguageId = self.langState
                    self.showingChosenLanguages.toggle()
                }, label: {
                    Text("Confirmar")
                        .fontWeight(.semibold)
                        .font(Font.custom("Georgia", size: 25))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                })
                    .padding()
                    .background(Color(red: 50/255, green: 50/255, blue: 255/255))
                    .cornerRadius(40)
                    .padding(.top, -120)
                        
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(Text("Mudar língua"), displayMode: .inline)
            .navigationBarItems(
                trailing: cancelButton
            )
        }
        
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView(showingChosenLanguages: .constant(true), langState: State<Int>(initialValue: 0))
            .environmentObject(UserData())
    }
}