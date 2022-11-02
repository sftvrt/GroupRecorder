//
//  Aufnahme&Verbindung.swift
//  Bachelorarbeit
//
//  Created by JT X on 10.12.20.
//


// Aufnahme + Nachrichtsenden
import SwiftUI
import MultipeerConnectivity

struct AufnahmeUI: View{
    
    @EnvironmentObject var rootVM: RootViewModel
    
    @EnvironmentObject var nearbyService: NearbyService
    @EnvironmentObject var audioRecorder: AudioRecorder
    
    @State var profiles: [Profile]?
    @State var navTitle  = "AudioRecorder"
    @State var state: MCSessionState?
    @State var timeInfo: [String:String] = [:]
    @State private var showingAlert = false
    @State private var showingResult = false
    @State var startAnimation = false
    @State var pluse1 = false
    @State var pluse2 = false
    @State var finischAnimation = false
    @State var showFindingAnimation = true
    
    @State var homeView = HomeView()
    
    @State var foundPeople: [People] = [
        People(image:"Image1", name: "girl"),
        People(image: "Image2", name: "boy")
    ]
    
    
    func changeAnimation(finischAnimation:Bool) -> some View  {
        
        return
            
            ZStack{
            ForEach(foundPeople) {
                people in Image(people.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(5)
                    .background(Color.white.clipShape(Circle()))
                    .offset(people.offset)
            }
            
            Circle()
                .stroke(Color.gray.opacity(0.6))
                .frame(width: 130, height: 130)
                .scaleEffect(pluse1 ? 3.3:0)
                .opacity(pluse1 ? 0:1)
            
            Circle()
                .stroke(Color.gray.opacity(0.6))
                .frame(width: 130, height: 130)
                .scaleEffect(pluse1 ? 3.3:0)
                .opacity(pluse1 ? 0:1)
            
            Circle()
                .fill(Color.white)
                .frame(width: 130, height: 130)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
            
            Circle()
               // .stroke(Color("Color1"), lineWidth: 1.4)
                .stroke(Color.green, lineWidth: 1.4)
                .frame(width: finischAnimation ? 70:30, height: finischAnimation ? 70:30)
                .overlay(Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .opacity(finischAnimation ? 1:0)
                )
                
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.4)
                   // .stroke(Color("Color1"), lineWidth: 1.4)
                    .stroke(Color.green, lineWidth: 1.4)
                Circle()
                    .trim(from: 0, to: 0.4)
                    //.stroke(Color("Color1"), lineWidth: 1.4)
                    .stroke(Color.green, lineWidth: 1.4)
                    .rotationEffect(.init(degrees: -180))
            }
            .frame(width: 70, height: 70)
          //  .rotationEffect(.init(degrees: startAnimation ? 360:0))
            
        }.frame(maxWidth: .infinity, maxHeight: 650)
        .ignoresSafeArea()
          .background(Color.blue.opacity(0.05).ignoresSafeArea())
        /*
            .onAppear(perform: {
                animationView()
            })
        */
        
          .onAppear(perform: {
              if finischAnimation == false {
                  animationView()
              }
          })
    }
  //  }
    
    func animationView(){
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
            startAnimation.toggle()
        }
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
            pluse1.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
                pluse2.toggle()
            }
        }
    }
   
    
    var body: some View {
        VStack {
            NavigationLink("Exporting finish link", isActive: $showingResult) {
                showFiles()
                    .environmentObject(audioRecorder)
                    .environmentObject(nearbyService)
                    .environmentObject(rootVM)
            }
            .hidden()
            
            changeAnimation(finischAnimation: finischAnimation)

            Participants(audioRecorder: audioRecorder)
            if audioRecorder.recording == false {
                Button(action:{
                    if self.nearbyService.isBrowser {
                        self.nearbyService.send(msg: "Meeting Preparation")
                        self.timeInfo["sendMeetingTime"] = Date().milliStamp
                        
                        self.audioRecorder.startRecording()
                        navTitle = "Recording..."
                        self.timeInfo["startRecordingTime"] = Date().milliStamp
                        
                
                        self.audioRecorder.exportCompletedBlock = {
                            self.showingAlert = false
                            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                                DispatchQueue.main.async {
                                    self.showingResult = true
                                }
                            }
                        }
                        
                    }
                }){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.red)
                        .frame(width: 100 , height: 100)
                        .clipped()
                        .overlay(Circle().stroke(Color.black , lineWidth: 4))
                        .padding(.bottom , 20)
                }
            }
            else {
                if self.nearbyService.isBrowser {
                    HStack {
                        Button(action:{
                            audioRecorder.opsTimeIndex += 1
                            let opsTimeKey = "opsTime\(audioRecorder.opsTimeIndex)"
                            self.timeInfo[opsTimeKey] = Date().milliStamp
                        }){
                            Image("ImageUPS")
                                //.font(.system(size: 30))
                                .resizable()
                                .scaledToFit()
                              //  .imageScale(.small)
                             //   .foregroundColor(.red)
                                .frame(width: 54 , height: 54)
                                .clipped()
                                .padding(20)
                        }
                        
                        Button(action:{
                            audioRecorder.importentTimeIndex += 1
                            let importentTimeKey = "importentTime\(audioRecorder.importentTimeIndex)"
                            self.timeInfo[importentTimeKey] = Date().milliStamp
                            
                        }){
                            Image("ImageOH")
                                //.font(.system(size: 30))
                                .resizable()
                                .scaledToFit()
                               // .imageScale(.small)
                              //  .foregroundColor(.green)
                               .frame(width: 54 , height: 54)
                                .clipped()
                                .padding(20)
                        }
                    }
                }
                HStack {
                    if self.nearbyService.isBrowser {
                        Button(action:{
                            self.showingAlert = true
                            self.audioRecorder.stopRecording()
                            self.timeInfo["stopRecordingTime"] = Date().milliStamp
                            self.profiles?[0].timeInfo = self.timeInfo
                            navTitle  = "AudioRecorder"
                            self.nearbyService.send(msg: self.profiles.toJSONString())
                            let name = nearbyService.isBrowser ? nearbyService.sitzung.title : nearbyService.peerID.displayName
                            
                            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                                do {
                                    try DataStorageManager().storeProfiles(profiles:self.profiles!, name: name)
                                } catch {
                                    print("End \(error)")
                                }
                            }
                        }){
                            Text("End")
                                .frame(width: 70 , height: 44)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                    
                    Button(action:{
                        if self.nearbyService.isBrowser {
                            self.audioRecorder.pauseRecording()
                            let pauseTimeKey = "\(audioRecorder.isPause ? "pauseTime" : "p_RecordingTime")\(audioRecorder.pauseIndex)"
                            self.timeInfo[pauseTimeKey] = Date().milliStamp
                            
                            navTitle = audioRecorder.isPause ? "Pause..." : "Recording..."
                            
                        }
                    }){
                        Image(systemName: audioRecorder.isPause ? "pause.circle" : "record.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 100 , height: 100)
                            .clipped()
                            .overlay(Circle().stroke(Color.black , lineWidth: 4))
                            .padding(.bottom , 20)
                            .padding(.leading , audioRecorder.recording ? (self.nearbyService.isBrowser ? 20 : 90) : 0)
                            .padding(.trailing , audioRecorder.recording ? 20 : 0)
                        
                    }
                    
                    // mute function
                    /*
                     Button(action:{
                     self.audioRecorder.muteRecording()
                     navTitle = audioRecorder.isMute ? "You are muted" : "Recording..."
                     }){
                     Text(audioRecorder.isMute ? "unmute" : "mute")
                     .frame(width: 70 , height: 44)
                     .background(Color.green)
                     .foregroundColor(.white)
                     .cornerRadius(5)
                     }
                     */
                }
            }
        }
        .navigationBarTitle(navTitle,displayMode: .inline)
        .font(.callout)
        .onAppear{
            // only if participant accepted control
            audioRecorder.fetchRecordings()
            if !nearbyService.isBrowser && self.state != .connected  {
                nearbyService.startAdvertising()
                self.state = MCSessionState(rawValue: 0)!
                navTitle = "waiting for connection..."
            }
            if nearbyService.isBrowser{
                finischAnimation = true
            }
            nearbyService.nearbyServiceDelegate = self
            self.profiles = [nearbyService.userData.profile]
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Exporting..."),
                  message: Text("Please wait a moment"))
        }
    }
}

extension AufnahmeUI:SuchenDelegate {
    func connectingState(state: MCSessionState) {
        self.state = state
        self.updateNavTitle(state: state)
        self.audioRecorder.updateOnlineState()
    }
    
    func updateNavTitle(state: MCSessionState) {
        switch state{
        case .connecting:
            navTitle = "connecting..."
            finischAnimation = false
            break
        case .connected:
            navTitle = "successfully connected"
            finischAnimation = true
            break
        case .notConnected:
            navTitle = "waiting for connection..."
            
            break
        @unknown default:
            print("unknown state:\(state)")
        }
    }
    

    
    func didReceiveFile(url: URL) {
        self.audioRecorder.fetchRecordings()
    }
    
    func didReceive(msg: String) {
        if msg == "start" {
            if self.audioRecorder.isPlay {
                self.audioRecorder.pasue()
            }
            self.audioRecorder.startRecording()
            self.timeInfo["startRecordingTime"] = Date().milliStamp
            navTitle = "Recording..."
            print("start recording")
        }else if msg == "stop" {
            print("stop recording")
            self.showingAlert = true
            self.audioRecorder.stopRecording()
            self.timeInfo["stopRecordingTime"] = Date().milliStamp
            nearbyService.userData.profile.timeInfo = self.timeInfo
            self.nearbyService.send(msg: nearbyService.userData.profile.toJSONString())
            
            self.profiles = [nearbyService.userData.profile]
            self.updateNavTitle(state: self.state!)
            
            self.audioRecorder.exportCompletedBlock = {
                self.showingAlert = false
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    DispatchQueue.main.async {
                        self.showingResult = true
                    }
                }
            }
        }else if msg == "pause" {
            self.audioRecorder.pauseRecording()
            let pauseTimeKey = "pauseTime\(audioRecorder.pauseIndex)"
            self.timeInfo[pauseTimeKey] = Date().milliStamp
            
            navTitle = "Pause..."
        }else if msg == "record" {
            self.audioRecorder.pauseRecording()
            let pauseTimeKey = "p_Recording\(audioRecorder.pauseIndex)"
            self.timeInfo[pauseTimeKey] = Date().milliStamp
            
            navTitle = "Recording..."
        }else if msg == "Meeting Preparation" {
            self.timeInfo["receiveMeetingTime"] = Date().milliStamp
        }else {
            if self.nearbyService.isBrowser {
                guard let jsonData = msg.jSONStringToData() else {
                    return
                }
                
                if let profile = try? JSONDecoder().decode(Profile.self, from: jsonData) {
                    self.profiles?.append(profile)
                }
                
            }else {
                guard let jsonData = msg.jSONStringToData() else {
                    return
                }
                
                if let profiles = try? JSONDecoder().decode([Profile].self, from: jsonData) {
                    let name = nearbyService.isBrowser ? nearbyService.sitzung.title : nearbyService.peerID.displayName
                    
                    do {
                        try DataStorageManager().storeProfiles(profiles:profiles,name:name)
                    } catch {
                        print("End \(error)")
                    }
                }
            }
        }
        
        print("didReceive \(msg)")
    }
}


