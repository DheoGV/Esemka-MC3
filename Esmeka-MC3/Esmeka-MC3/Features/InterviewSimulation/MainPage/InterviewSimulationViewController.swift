//
//  InterviewSimulationViewController.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 28/07/21.
//

import UIKit
import ARKit
import AVFoundation
import SoundAnalysis

class InterviewSimulationViewController: UIViewController, SegregationClassifierDelegate, EmotionClassifierDelegate {
  
    
    static let identifier = "InterviewSimulationViewController"
    @IBOutlet weak var scene: ARSCNView!
    @IBOutlet weak var recordButton: UIButton!
    @IBAction func recordButtonAction(_ sender: Any) {
        recordButtonTapped()
    }
    //--------------- Voice Analyzer Variable --------------
    var segregationObserver = SegregationObserver()
    var emotionObserver = EmotionObserver()
    let audioEngine = AVAudioEngine()
    let voiceSegregetion = InterjectionClassifier()
    let voiceEmotion = SoundEmotionClassifier_1()
    var inputFormat : AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    var audioOn = false
    var interjection : Double = 0
    var keepCounting = true
    // -------------------- Timer -------------------------
    var timerTimeNow : Double = 0
    var timerToMinute : Double = 0
    var timer : Timer?
    // ---------------------------------------------------
    var isStart : Bool = false
    var idealInterjectionNumber : Double = 0
    var outputInterjection : Double = 0
    var promptWindow: UIView!
    
    override func viewDidLoad() {
        //--------------- Voice Analyzer Mechanism --------------
        segregationObserver.delegate = self
        emotionObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        //------------------------------------------------------
        super.viewDidLoad()
        buttonSetup()
        // Do any additional setup after loading the view.
    }
    
    func buttonSetup(){
        recordButton.layer.cornerRadius = recordButton.frame.height / 2
        recordButton.backgroundColor = UIColor.ColorLibrary.blueAccent
        recordButton.tintColor = .white
    }
    
    func callPromptWindow(){
        promptWindow = PromptQuestionView()
        view.addSubview(promptWindow)
        let constraints = [
            promptWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptWindow.topAnchor.constraint(equalTo: view.topAnchor) //masih belom fix
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    ///MARK: set it to @IBAction, and add appropriate functions
    func recordButtonTapped(){
        if isStart {
            removeAudioEngine()
            recordButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
        } else {
            recordButton.backgroundColor = .white
            recordButton.tintColor = UIColor.ColorLibrary.blueAccent
            recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
            
            callPromptWindow()
            startRecording()
            startAudioEngine()
            
        }
        isStart = !isStart
        calculateOutputInterjection()
        timerInterview()
        
        
      
    }
    
    
    
    func startTimerView(){
       
    }
  
    
    func startRecording(){
        
    }
    
}

