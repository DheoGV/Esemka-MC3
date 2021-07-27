//
//  HomeViewController.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 23/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:: Button going to Simulator
   static let identifier = "HomeViewController"
    
    @IBOutlet weak var goToSimulatorButton: UIButton!
    
   

    @IBAction func goToVoiceSegregation(_ sender: Any) {
        let voiceSegregationVc = VoiceSegregetionViewController(nibName: VoiceSegregetionViewController.identifier, bundle: nil)
        navigationController?.pushViewController(voiceSegregationVc, animated: true)
    }
    
    @IBAction func GoToSimulator(_ sender: Any) {
        let simulatorVc = SimulatorViewController(nibName: SimulatorViewController.identifier, bundle: nil)
               navigationController?.pushViewController( simulatorVc, animated: true)
    }
    // Try Navigation - END
    
    //MARK:: Make Lazy for single isntance only, it prevent memory leak
    private lazy var coredataProvider: CoredataProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return CoredataProvider(appDelegate)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    //MARK:: Example to Insert The value
    private func insertInterview(){
        let date = Date()
        var listAssessment: [AssessmentModel] = []
        let assessmentModelOne = AssessmentModel(assessmentId: 1, assessmentQuestion: "Pertanyaan 1")
        let assessmentModelTwo = AssessmentModel(assessmentId: 2, assessmentQuestion: "Pertanyaan 2")
        listAssessment.append(contentsOf: [assessmentModelTwo, assessmentModelOne])
    
        var listScore: [ScoreTypeModel] = []
        let scoreModelOne = ScoreTypeModel(scoreTypeId: 1, scoreTypeName: "Verbal", score: 10)
        let scoreModelTwo = ScoreTypeModel(scoreTypeId: 2, scoreTypeName: "Communication", score: 9)
        
        listScore.append(contentsOf: [scoreModelOne, scoreModelTwo])
        
        let interviewModel = InterviewModel(interviewId: 0, duration: 5, interviewTitle: "Title", interviewDate: date, interviewURLPath: "URL PATH")
        
        coredataProvider.addInterview(interviewModel: interviewModel, listAssessmentModel: listAssessment, listScoreTypeModel: listScore)
    }
    
    //MARK::Example Get All the interview
    private func getAllInterview(){
        let listInterviewEntity = coredataProvider.getAllInterview()
        listInterviewEntity.forEach { result in
            print("Scores", result.scores?.value(forKey: "score_value"))
            print("Date", result.interview_date)
            print("Duration", result.interview_duration)
            print("Question", result.assessments?.value(forKey: "assessment_question"))
        }
        
        let listScoresEntity = coredataProvider.getAllScores()
        
        listScoresEntity.forEach { score in
            print("Score", score)
        }
        
        let listQuestion = coredataProvider.getAllQuestion()
        
        listQuestion.forEach { score in
            print("Question", score)
        }
    }
}
