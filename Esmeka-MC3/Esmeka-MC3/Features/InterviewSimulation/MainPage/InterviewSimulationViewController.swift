//
//  InterviewSimulationViewController.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 28/07/21.
//

import UIKit
import ARKit

class InterviewSimulationViewController: UIViewController {
    @IBOutlet weak var scene: ARSCNView!
    @IBOutlet weak var recordButton: UIButton!
    
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        scene.delegate = self
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
    
    ///MARK: set it to @IBAction, and add appropriate functions
    @IBAction func recordButtonTapped(_sender: Any){
        if !isRecording{
            isRecording = true
            recordButton.backgroundColor = .white
            recordButton.tintColor = UIColor.ColorLibrary.blueAccent
            recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
            
            startTimerView()
            callPromptWindow()
            startRecording()
        }
        else{
            isRecording = false
            stopRecording()
            toCompletedPage()
        }
        
    }
    
    func startTimerView(){
        
    }
    
    func startRecording(){
        
    }
    
    func stopRecording(){
        
    }

    func toCompletedPage(){
        let completedVC = CompleteViewController(nibName: "CompleteViewController", bundle: nil)
        navigationController?.pushViewController(completedVC, animated: true)
    }
    
}

extension InterviewSimulationViewController: ARSCNViewDelegate{}
