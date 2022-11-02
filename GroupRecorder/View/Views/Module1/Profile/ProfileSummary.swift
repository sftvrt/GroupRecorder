//
//  ProfileSummary.swift
//  Bachelorarbeit
//
//  Created by JT X on 18.10.20.
//


import SwiftUI

struct ProfileSummary: View {
    @State var submit = false
    @StateObject var locationViewModel = LocationViewModel()
    @EnvironmentObject var userData: UserData
    
    @EnvironmentObject var selectedLanguage : LanguageSettings
    @EnvironmentObject var selectedLang : LanguageSettings
    var userLatitude: String{
        return "\(locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String{
        return "\(locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)"
    }
    var userCity: String{
        return "\(locationViewModel.currentPlacemark?.locality ?? "")"
    }
    var userCountry: String{
        return "\(locationViewModel.currentPlacemark?.country ?? "")"
    }
    
    var body: some View {
        NavigationView{
            Form{
                Text(userData.profile.username).bold()
                /*
                Text("Geschlecht: \(userData.profile.Geschlecht.rawValue)")
                */
                Text("Geschlecht:\(userData.profile.Geschlecht)")
                
                Text("Alter:\(userData.profile.Alter)")
                
                Text("Regionale Herkunft:\(userData.profile.regionaleHerkunft)")
                
                HStack{
                    Button(action: {
                        locationViewModel.requestPermission()
                    }, label: {
                       // Label("Allow tracking", systemImage: "location")
                        Image(systemName: "location")
                    })
                    
                    Text("Standort: \(userCity)")
                }
               
                
                
                
             //   Text("Latitude: \(userLatitude)")
              //  Text("Longitude: \(userLongitude)")
            //    Text("City:\(userCity)")
            //    Text("County: \(userCountry)")
            }
            .navigationBarTitle(  texts[26].localizedStr(language: (selectedLang.lang == .zh) ? "zh-Hans" : selectedLang.lang.rawValue))
            .onDisappear {
                self.userData.profile.userLatitude = userLatitude
                self.userData.profile.userLongitude = userLongitude
                self.userData.profile.userCity = userCity
                self.userData.profile.userCountry = userCountry
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary()
    }
}

