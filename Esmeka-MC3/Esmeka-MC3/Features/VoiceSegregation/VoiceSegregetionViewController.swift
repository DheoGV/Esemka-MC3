//
//  VoiceSegregetionViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import UIKit
import AVFoundation
import SoundAnalysis

//MARK:: ERROR when stop avaudioEngine
// Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',
//reason: 'required condition is false: nullptr == Tap()'
//terminating with uncaught exception of type NSException

class VoiceSegregetionViewController: UIViewController{
    static let identifier = "VoiceSegregetionViewController"
    var resultsObserver = ResultsObserver()
    let audioEngine = AVAudioEngine()
    let voiceSegregetion = InterjectionClassifier()
    var inputFormat : AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    var audioOn = false
    var interjection = 0
    var keepCounting = true
    
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelClassify: UILabel!
    @IBAction func startVoice(_ sender: Any) {
            startAudioEngine()
    }
    
    @IBAction func stopVoice(_ sender: Any) {
        removeAudioEngine()
    }

    
    
    override func viewDidLoad() {
        resultsObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
}


