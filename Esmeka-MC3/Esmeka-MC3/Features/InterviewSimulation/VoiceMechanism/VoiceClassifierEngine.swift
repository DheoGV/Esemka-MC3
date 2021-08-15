//
//  VoiceClassifierEngine.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 13/08/21.
//

import UIKit
import AVFoundation
import SoundAnalysis

class VoiceClassifierEngine: SegregationClassifierDelegate, EmotionClassifierDelegate{
    
    //--------------- Voice Analyzer Variable --------------
    private let audioEngine = AVAudioEngine()
    private var inputFormat : AVAudioFormat!
    private var analyzer: SNAudioStreamAnalyzer!
    private let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    
    // -------------------- Timer -------------------------
    var timerTimeNow : Double = 0
    private var timerToMinute : Double = 0
    private var timer : Timer?
    private var idealInterjectionNumber : Double = 0
    private var outputInterjection : Double = 0
    
    //    ----------------Voice Segregation ----------------
    private let voiceSegregetion = InterjectionClassifier()
    private var segregationObserver = SegregationObserver()
    private var audioOn = false
    private var interjection = 0
    private var keepCounting = true
    
    //    ----------------Voice Emotion ----------------
    private let voiceEmotion = SoundEmotionClassifier()
    private var emotionObserver = EmotionObserver()
    private var availableEmotions : [String : String] = ["angry":"bad", "disgust":"bad", "fear":"bad", "happy":"good", "neutral":"good", "ps":"good", "sad":"bad"]
    private var totalVoiceEmotions = 0
    private var binaryEmotions:[String: Int] = ["good": 0, "bad": 0]
    private var voiceEmotionScore:Int = 0
    
    
    init() {
        segregationObserver.delegate = self
        emotionObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
    }
    
    func startEngine() {
        do {
            let request = try SNClassifySoundRequest(mlModel: voiceSegregetion.model)
            try analyzer.add(request, withObserver: segregationObserver)
            let request2 = try SNClassifySoundRequest(mlModel: voiceEmotion.model)
            try analyzer.add(request2, withObserver: emotionObserver)
            timerInterview()
            
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
    
    func removeEngine() {
        audioOn = false
        audioEngine.stop()
        audioEngine.inputNode.reset()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    func countInterjection(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                if identifier == "Interjection"{
                    self.interjection += 1
                }
            }
        }
    }
    func countEmotionParameter(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                self.totalVoiceEmotions += 1
                self.binaryEmotions[self.availableEmotions[identifier]!]! += 1
                
            }
        }
    }
    
    func getVoiceEmotionScore()->Int {
        var score = 0
        let goodEmotion = binaryEmotions["good"] ?? 0
        if  goodEmotion > 0 {
            score = Int(goodEmotion * 100 / totalVoiceEmotions)
        }
        return score
    }
    
    func getInterjectionScore()->Int{
        var score =  0.0
        if self.idealInterjectionNumber > 0 {
            score = self.idealInterjectionNumber/Double(self.interjection)*100
            if score > 100 {
                score = 100
            }
            
        }
        return Int(score)
    }
    
    private func timerInterview()  {
        timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func printTimer() {
        if audioOn {
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
