//
//  AudioEngine.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import Foundation
import  AVFoundation
import SoundAnalysis

//MARK:: Controlling AudioEngine and Voice Analyzer Request
extension VoiceSegregetionViewController {
    
   func startAudioEngine() {
        do {
            let request = try SNClassifySoundRequest(mlModel: voiceSegregetion.model)
            try analyzer.add(request, withObserver: segregationObserver)
            let request2 = try SNClassifySoundRequest(mlModel: voiceEmotion.model)
            try analyzer.add(request2, withObserver: emotionObserver)
        } catch {
            print("unable to start audio")
            return
        }
        // to remove the Tap bug
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
            self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
        do {
            try audioEngine.start()
            audioOn = true
        } catch {
            print("audioEngine.start() failed")
        }
        
    }
    
    func removeAudioEngine() {
        audioEngine.stop()
        audioEngine.inputNode.reset()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
}
