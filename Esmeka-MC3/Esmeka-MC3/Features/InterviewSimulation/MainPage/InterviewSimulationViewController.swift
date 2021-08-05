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

struct Coordinate {
    var x: Int
    var y: Int
}

class InterviewSimulationViewController: UIViewController, SegregationClassifierDelegate, EmotionClassifierDelegate {
    
    func countEmotionParameter(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                self.totalEmotions += 1
                self.binaryEmotions[self.availableEmotions[identifier]!]! += 1
                
            }
            print("Output Voice Emotion : ", self.totalEmotions)
        }
    }
    
    @IBOutlet weak var scene: ARSCNView!
    @IBOutlet weak var recordButton: UIButton!
    @IBAction func startRecordingAction(_ sender: Any) {
        
    }
    
    //Face Emotion
    //let model = try! VNCoreMLModel(for: CNNEmotions().model)
    var totalEmotion = 0
    var goodEmotion = 0
    var faceEmotionScore:Int = 0
    
    //EyeTracking
    var listOfCoordinate:[Coordinate] = []
    var listOfCoordinateTemp:[Coordinate] = []
    var countFrameRenderer = 0
    let globalQueue = DispatchQueue.global(qos: .default)
    var countMiss = 0
    var countMissInSecond = 0
    var countMissFrameRenderer = 0
    
    //    VOICE
    var segregationObserver = SegregationObserver()
    var emotionObserver = EmotionObserver()
    let audioEngine = AVAudioEngine()
    let voiceSegregetion = InterjectionClassifier()
    let voiceEmotion = SoundEmotionClassifier()
    var inputFormat : AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    var audioOn = false
    var interjection = 0
    var keepCounting = true
    //--------------- Voice Analyzer Variable --------------
    // -------------------- Timer -------------------------
    var timerTimeNow : Double = 0
    var timerToMinute : Double = 0
    var timer : Timer?
    
    var isRecording : Bool = false
    var idealInterjectionNumber : Double = 0
    var outputInterjection : Double = 0
    //    ----------------Voice Emotion ----------------
    var availableEmotions : [String : String] = ["angry":"bad", "disgust":"bad", "fear":"bad", "happy":"good", "neutral":"good", "ps":"good", "sad":"bad"]
    var totalEmotions = 0
    var binaryEmotions:[String: Int] = ["good":0, "bad":0]
    var voiceEmotionScore:Int = 0
    // ---------------------------------------------------
    
    
    override func viewDidLoad() {
        segregationObserver.delegate = self
        emotionObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        super.viewDidLoad()
        buttonSetup()
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        let config = ARFaceTrackingConfiguration()
        scene.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        scene.session.pause()
    }
    
    func setup() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        scene.delegate = self
        scene.showsStatistics = true
        scene.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
        scene.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        //        scene.showsStatistics = true
        buttonSetup()
    }
    
    func buttonSetup(){
        recordButton.layer.cornerRadius = recordButton.frame.height / 2
        recordButton.backgroundColor = UIColor.ColorLibrary.blueAccent
        recordButton.tintColor = .white
    }
    
    func callPromptWindow(){
        //        Bundle.loadNibNamed("PromptQuestionView", owner: self, options: nil)
        //        promptWindow.prepareForInterfaceBuilder()
        let topMargin = view.safeAreaInsets.top
        let leadMargin = view.safeAreaInsets.left
        let height = view.frame.size.height/4
        let width = view.frame.size.width - (2*leadMargin)
        let frame = CGRect(x: leadMargin, y: topMargin, width: width, height: height)
        let promptWindow = PromptQuestionView(frame: frame)
        view.addSubview(promptWindow)
        
    }
    
    func saveFaceEmotionScore() {
        if goodEmotion > 0 {
            faceEmotionScore = Int(goodEmotion * 100 / totalEmotion)
        }
        else{
            faceEmotionScore = 0
        }
        print("Score face Emotion: \(faceEmotionScore)")
        //save to core data
    }
    
    
    ///MARK: set it to @IBAction, and add appropriate functions
    @IBAction func recordButtonTapped(_sender: Any){
        if isRecording {
            removeAudioEngine()
            stopRecording()
            toCompletedPage()
            
        } else {
            recordButton.backgroundColor = .white
            recordButton.tintColor = UIColor.ColorLibrary.blueAccent
            recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
            
            callPromptWindow()
            startRecording()
            //          Call this : VOICE
            startAudioEngine()
            
        }
        isRecording = !isRecording
        //        Call this : VOICE
        calculateOutputInterjection()
        saveFaceEmotionScore()
        timerInterview()
        
    }
    
    func startTimerView(){
        
    }
    
    func toCompletedPage(){
        let completedVC = CompleteViewController(nibName: "CompleteViewController", bundle: nil)
        navigationController?.pushViewController(completedVC, animated: true)
    }
    
}


