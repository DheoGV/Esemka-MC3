//
//  ExtensionVoice.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 02/08/21.
//

import Foundation
import AVFoundation
import SoundAnalysis


extension InterviewSimulationViewController {
    
    
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                if identifier == "Interjection"{
                    self.interjection += 1
//                    print(self.interjection)
                }
            }
        }
    }
    
    func displayPredictionResult2(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
//                print(identifier)
            }
        }
    }
    
    
    
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
    
    
    func calculateOutputInterjection() {
        if self.idealInterjectionNumber > 0 {
            self.outputInterjection = self.idealInterjectionNumber/Double(self.interjection)*100
            if outputInterjection > 100 {
                outputInterjection = 100
            }
            
        }
        
        print("Output Segregation : ",outputInterjection)
        // do something about the output : send to core data
    }
    
    func timerInterview()  {
        timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printTimer), userInfo: nil, repeats: true)
    }
    
    @objc func printTimer() {
        if isRecording {
            timerToMinute = (timerTimeNow/60)
            idealInterjectionNumber = timerToMinute*15
//            print("Seconds : ",timerTimeNow)
//            print("Minute : ",timerToMinute)
//            print("Ideal Interjection Number : ",idealInterjectionNumber)
//            print("Simulation Interjection Number : ",interjection)
            timerTimeNow += 1
     
        } else {
            timer?.invalidate()
            keepCounting = false
            
        }
    }
    
}
