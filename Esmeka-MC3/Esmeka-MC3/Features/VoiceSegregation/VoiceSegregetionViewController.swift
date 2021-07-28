//
//  VoiceSegregetionViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import UIKit
import AVFoundation
import SoundAnalysis

class VoiceSegregetionViewController: UIViewController, SegregationClassifierDelegate, EmotionClassifierDelegate{
    static let identifier = "VoiceSegregetionViewController"
    var segregationObserver = SegregationObserver()
    var emotionObserver = EmotionObserver()
    let audioEngine = AVAudioEngine()
    let voiceSegregetion = InterjectionClassifier()
    let voiceEmotion = SoundEmotionClassifier_1()
    var inputFormat : AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    var audioOn = false
    var interjection = 0
    var keepCounting = true
    
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelClassify: UILabel!
//    @IBOutlet weak var labelClassify2: UILabel!
    @IBAction func startVoice(_ sender: Any) {
            startAudioEngine()
    }
    
    @IBAction func stopVoice(_ sender: Any) {
        removeAudioEngine()
    }

    
    override func viewDidLoad() {
        segregationObserver.delegate = self
        emotionObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
}


