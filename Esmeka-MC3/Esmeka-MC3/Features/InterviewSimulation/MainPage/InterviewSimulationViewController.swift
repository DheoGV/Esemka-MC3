//
//  InterviewSimulationViewController.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 28/07/21.
//

import UIKit
import ARKit

class InterviewSimulationViewController: UIViewController {
    static let identifier = "InterviewSimulationViewController"
    @IBOutlet weak var scene: ARSCNView!
    @IBOutlet weak var recordButton: UIButton!
    
    var promptWindow: UIView!
    
    override func viewDidLoad() {
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
        recordButton.backgroundColor = .white
        recordButton.tintColor = UIColor.ColorLibrary.blueAccent
        recordButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        
        startTimerView()
        callPromptWindow()
        startRecording()
        
    }
    
    func startTimerView(){
        
    }
    
    func startRecording(){
        
    }
    
}
