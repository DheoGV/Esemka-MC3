//
//  HomeViewController.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 23/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:: Make Lazy for single isntance only, it prevent memory leak
    private lazy var coredataProvider: CoredataProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return CoredataProvider(appDelegate)
    }()
    
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  insertInterview()
      //  insertInterview()
        
        getAllInterview()
    }
    
    //MARK:: Example to Insert the Data
       private func insertInterview(){
           let date = Date()
           var listAssessment: [AssessmentModel] = []
           let assessmentModelOne = AssessmentModel(assessmentId: 1, assessmentQuestion: "Pertanyaan 1")
           let assessmentModelTwo = AssessmentModel(assessmentId: 2, assessmentQuestion: "Pertanyaan 2")
           listAssessment.append(contentsOf: [assessmentModelTwo, assessmentModelOne])
           
           var listScore: [ScoreTypeModel] = []
           let scoreModelOne = ScoreTypeModel(scoreTypeName: scoreType.eyeMovement, score: 10)
           let scoreModelTwo = ScoreTypeModel(scoreTypeName: scoreType.facialExpression, score: 9)
           let scoreModelThree = ScoreTypeModel(scoreTypeName: scoreType.voiceEmotion, score: 9)
           let scoreModelFour = ScoreTypeModel(scoreTypeName: scoreType.voiceSegregation, score: 9)
           
           listScore.append(contentsOf: [scoreModelOne, scoreModelTwo, scoreModelThree, scoreModelFour])
           let currVideo =  VideoFetchClass().loadLastVideo()
            currVideo.getURL { [self] url in
            do {
                data = try Data(contentsOf: url!)
                print("SUCCESS", self.data)
                
                let interviewModel = InterviewModel(interviewId: 1,duration: 5, interviewDate: date, interviewURLPath: data)
                
                print("Interview Model \(interviewModel.interviewURLPath)")
                DispatchQueue.main.async {
                    coredataProvider.addInterview(interviewModel: interviewModel, listAssessmentModel: listAssessment, listScoreTypeModel: listScore)
                }
              
            } catch {
                print("ERROR")
            }
        
           }
         
       }
       
       //MARK:: Example How to Insert the Data
       private func insertSecondInterview(){
           let date = Date()
           var listAssessment: [AssessmentModel] = []
           let assessmentModelOne = AssessmentModel(assessmentId: 1, assessmentQuestion: "Pertanyaan 3")
           let assessmentModelTwo = AssessmentModel(assessmentId: 2, assessmentQuestion: "Pertanyaan 4")
           listAssessment.append(contentsOf: [assessmentModelTwo, assessmentModelOne])
           
           var listScore: [ScoreTypeModel] = []
           let scoreModelOne = ScoreTypeModel(scoreTypeName: scoreType.eyeMovement, score: 5)
           let scoreModelTwo = ScoreTypeModel(scoreTypeName: scoreType.facialExpression, score: 5)
           let scoreModelThree = ScoreTypeModel(scoreTypeName: scoreType.voiceEmotion, score: 5)
           let scoreModelFour = ScoreTypeModel(scoreTypeName: scoreType.voiceSegregation, score: 5)
           
           listScore.append(contentsOf: [scoreModelOne, scoreModelTwo, scoreModelThree, scoreModelFour])
           
           var currVideo =  VideoFetchClass().loadLastVideoWithTypeData()
           let interviewModel = InterviewModel(interviewId: 2,duration: 10, interviewDate: date, interviewURLPath: currVideo)
           
           coredataProvider.addInterview(interviewModel: interviewModel, listAssessmentModel: listAssessment, listScoreTypeModel: listScore)
       }
       
       //MARK::Example Get All the interview
       private func getAllInterview(){
           let listInterviewEntity = coredataProvider.getAllInterview()
           listInterviewEntity.forEach { result in
               print("Scores Value", result.scores?.value(forKey: "score_value"))
               print("Scores Type Name", result.scores?.value(forKey: "score_type_name"))
               print("Date", result.interview_date)
               print("Duration", result.interview_duration)
               print("Question", result.assessments?.value(forKey: "assessment_question"))
               print("Interview id", result.interview_id)
               print("URL WOYYYY", result.interview_video_url_path)
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
       //MARK:: Example How to Get Scores by Single Interview
       private func getSingleInterview(interviewId: Int){
           let scoresInterview = coredataProvider.getScoresByInteviewId(interviewId: interviewId)
           scoresInterview.forEach { score in
               print("Score Type Name", score.value(forKey: "score_type_name"))
               print("Score Value", score.value(forKey: "score_value"))
           }
       }
}
