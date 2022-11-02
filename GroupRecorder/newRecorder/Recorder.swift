//
//  Recorder.swift
//  Bachelorarbeit
//
//  Created by JT X on 11.09.22.
//

import AVFoundation

class Recorder {
  enum RecordingState {
    case recording, paused, stopped
  }
  
  private var engine: AVAudioEngine!
  private var mixerNode: AVAudioMixerNode!
  private var state: RecordingState = .stopped
   
  
  init() {
    setupSession()
    setupEngine()
  }
    
    fileprivate func setupSession() {
      let session = AVAudioSession.sharedInstance()
      try? session.setCategory(.record)
      try? session.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    
    fileprivate func setupEngine() {
      engine = AVAudioEngine()
      mixerNode = AVAudioMixerNode()

      // Set volume to 0 to avoid audio feedback while recording.
      mixerNode.volume = 0

      engine.attach(mixerNode)

      makeConnections()
      
      // Prepare the engine in advance, in order for the system to allocate the necessary resources.
      engine.prepare()
    }
    
    fileprivate func makeConnections() {
      let inputNode = engine.inputNode
      let inputFormat = inputNode.outputFormat(forBus: 0)
      engine.connect(inputNode, to: mixerNode, format: inputFormat)

      let mainMixerNode = engine.mainMixerNode
      let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
      engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)
    }
   
    func startRecording() throws {
        let inputNode = engine.inputNode
        var setting = engine.inputNode.inputFormat(forBus: 0).settings
        setting[AVLinearPCMBitDepthKey] = 16
        setting[AVSampleRateKey] = 16000
        setting[AVLinearPCMIsFloatKey] = 0
        
        // Like the stackoverflow
        // AGC
        // 
  /*      var turnOff:UInt32 = 0
       

        guard let outputAudioUnit = AudioKit.engine.outputNode.audioUnit else {
                   AKLog("ERROR: can't create outputAudioUnit")
                   return
               }
        AudioUnitSetProperty(kAudioUnitType_Output,
                             kAUVoiceIOProperty_VoiceProcessingEnableAGC,
                             kAudioUnitScope_Global,
                             0,
                             &turnOff,
                             0)
        */

      let tapNode: AVAudioNode = mixerNode
      let format = tapNode.outputFormat(forBus: 0)

      tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
        (buffer, time) in
        // Do something here
      })

      try engine.start()
      state = .recording
    }
    
    
    func resumeRecording() throws {
      try engine.start()
      state = .recording
    }

    func pauseRecording() {
      engine.pause()
      state = .paused
    }

    func stopRecording() {
      // Remove existing taps on nodes
      mixerNode.removeTap(onBus: 0)
      
      engine.stop()
      state = .stopped
    }
    
    
}

