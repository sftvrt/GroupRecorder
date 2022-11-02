//
//  ProfileEditor.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.10.20.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    @EnvironmentObject var selectedLanguage : LanguageSettings
    @EnvironmentObject var selectedLang : LanguageSettings
    
    var body: some View {
        List {
            HStack {
                Text(texts[14].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField("", text: $profile.username)
            }
            
            HStack {
                Text(texts[6].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(" ", text: $profile.Alter)
            }
            
            HStack {
                Text(texts[23].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(" ", text: $profile.regionaleHerkunft)
            }
            
            HStack {
                Text(texts[5].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(" ", text: $profile.Geschlecht)
            }
            
            HStack {
                Text(texts[8].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue)).bold()
                Divider()
                TextField(" ", text: $profile.regionaleHerkunft)
            }
            
           
            
            
            /*
            VStack(alignment: .leading, spacing: 20) {
                Text("Geschlecht").bold()
                
                Picker("Geschlecht", selection: $profile.Geschlecht) {
                    ForEach(Profile.Geschlecht.allCases, id: \.self) { season in
                        Text(season.rawValue).tag(season)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top)
            */
            
         
        
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
