//
//  InterviewSimulationViewController.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 28/07/21.
//

import UIKit
import ARKit
import Photos
import PhotosUI

class InterviewSimulationViewController: UIViewController{
    
    //MARK:: Make Lazy for single isntance only, it prevent memory leak
    private lazy var coredataProvider: CoredataProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return CoredataProvider(appDelegate)
    }()
    
    @IBOutlet weak var recordButton: UIButton!
    var scene = ARSCNView(frame: UIScreen.main.bounds)
    var prevVideo:PHAsset!
    var isVideoSaved = false
    var isRecording : Bool = false
    
    let voiceEngine = VoiceClassifierEngine()
    
    //Face Emotion
    //let model = try! VNCoreMLModel(for: CNNEmotions().model)
    var totalFaceEmotions = 0
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
    var resultValueEye = 100
    var tempResult = 0.0
    
    //-------------- User Default Key ------------------
    var idKey = "idKey"
    var id:Int = 0
    
    override func viewDidLoad() {
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
        view.addSubview(scene)
        scene.delegate = self
//        scene.showsStatistics = true
        scene.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
        buttonSetup()
    }
    
    
    func buttonSetup(){
        view.bringSubviewToFront(recordButton)
        recordButton.layer.cornerRadius = recordButton.frame.height / 2
        recordButton.backgroundColor = UIColor.ColorLibrary.blueAccent
        recordButton.tintColor = .white
    }
    
    func callPromptWindow(){
        let topMargin = view.safeAreaInsets.top + 25
        let leadMargin = view.safeAreaInsets.left + 16
        let height = view.frame.size.height/5
        let width = view.frame.size.width - (2*leadMargin)
        let frame = CGRect(x: leadMargin, y: topMargin, width: width, height: height)
        let promptWindow = PromptQuestionView(frame: frame)
        view.addSubview(promptWindow)
    }
    
    
    ///MARK: set it to @IBAction, and add appropriate functions
    @IBAction func recordButtonTapped(_sender: Any){
        if isRecording {
            voiceEngine.removeEngine()
            stopRecording()
            toCompletedPage()
            
        } else {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
                DispatchQueue.main.async { [unowned self] in
                    startRecording()
                }
            }
        }
        
    }
    
    func getFaceEmotionScore()->Int {
        var score = 0
        if goodEmotion > 0 {
            score = Int(goodEmotion * 100 / totalFaceEmotions)
        }
        return score
    }
    
    func startCountdownView(){
        recordButton.isHidden = true
        let timerView = TimerView(frame: UIScreen.main.bounds)
        let bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = .black
        bgView.alpha = 0.1
        view.addSubview(bgView)
        view.addSubview(timerView)
        
        var runCount = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            timerView.setCounter(number: 2-runCount)
            runCount += 1

            if runCount == 3 {
                timer.invalidate()
                timerView.removeFromSuperview()
                bgView.removeFromSuperview()
                self.allowedRecording()
            }
        }
    }
    
    func allowedRecording(){
        isRecording = !isRecording
        recordButton.isHidden = false
        recordButton.backgroundColor = .white
        recordButton.tintColor = UIColor.ColorLibrary.blueAccent
        recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        callPromptWindow()
        //          Call this : VOICE
        voiceEngine.startEngine()
        //MARK:: Count Eye Tracking
        countEyeTrackingMiss()

    }
    
    func toCompletedPage(){
        let completedVC = CompleteViewController(nibName: "CompleteViewController", bundle: nil)
        completedVC.interviewId = id
        navigationController?.pushViewController(completedVC, animated: true)
    }
    
    func saveData(){
        var listScore: [ScoreTypeModel] = []
        let voiceEmotion = ScoreTypeModel(scoreTypeName: .voiceEmotion, score: voiceEngine.getVoiceEmotionScore())
        let voiceSegregation = ScoreTypeModel(scoreTypeName: .voiceSegregation, score: voiceEngine.getInterjectionScore())
        let faceEmotion = ScoreTypeModel(scoreTypeName: .facialExpression, score: getFaceEmotionScore())
        let eyeMovement = ScoreTypeModel(scoreTypeName: .eyeMovement, score: resultValueEye)
        
        listScore.append(contentsOf: [voiceEmotion, voiceSegregation, faceEmotion, eyeMovement])
        
        //MARK:: User Default
        let preferences = UserDefaults.standard
        if preferences.object(forKey: idKey) != nil {
            id = preferences.integer(forKey: idKey)
        }
        var currVideoPHAsset = VideoFetchClass().loadLastVideo()
        var duration = 0.0
        var data = Data()
        //MARK:: If user saved the video
        if isVideoSaved{
            currVideoPHAsset = VideoFetchClass().loadLastVideo()
            duration = currVideoPHAsset.duration
            currVideoPHAsset.getURL { url in
                do {
                    data = try Data(contentsOf: url!)
                    print("SUCCESS", data)
                    
                    let interviewModel = InterviewModel(interviewId: self.id,duration: Int(duration), interviewDate: Date(), interviewURLPath: data)
                    
                    print("Interview Model \(interviewModel.interviewURLPath)")
                    DispatchQueue.main.async {
                        self.coredataProvider.addInterview(interviewModel: interviewModel, listAssessmentModel: [], listScoreTypeModel: listScore)
                    }
                  
                } catch {
                    print("ERROR")
                }

            }
            
            preferences.setValue(id+1, forKey: idKey)
        } else {
            currVideoPHAsset.getURL { url in
                do {
                    data = try Data(contentsOf: url!)
                    print("SUCCESS", data)
                    
                    let interviewModel = InterviewModel(interviewId: self.id,duration: Int(duration), interviewDate: Date(), interviewURLPath: data)
                    
                    print("Interview Model \(interviewModel.interviewURLPath)")
                    DispatchQueue.main.async {
                        self.coredataProvider.addInterview(interviewModel: interviewModel, listAssessmentModel: [], listScoreTypeModel: listScore)
                    }
                  
                } catch {
                    print("ERROR")
                }

            }
            
            preferences.setValue(id+1, forKey: idKey)
        }
        
        isVideoSaved = false
    }
}


