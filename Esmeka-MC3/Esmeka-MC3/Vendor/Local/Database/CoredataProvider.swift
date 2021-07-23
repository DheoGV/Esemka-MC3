//
//  CoredataProvider.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 23/07/21.
//

import Foundation
import CoreData

class CoredataProvider {
    
    //MARK:: refer to NSManagedObjectContext
    var context: NSManagedObjectContext?
    
    init(_ appDelegate: AppDelegate) {
        context = appDelegate.persistentContainer.viewContext
    }
    
    //MARK:: Add Inteview data to Local DB
    func addInterview(interviewModel: InterviewModel, listAssessmentModel: [AssessmentModel], listScoreTypeModel: [ScoreTypeModel] ){
        guard let taskContext = context else {
            return
        }
        //MARK:: Refer to Interview Entity
        let interviewEntity = InterviewEntity(context: taskContext)
        interviewEntity.interview_date = interviewModel.interviewDate
        interviewEntity.interview_duration = Int32(interviewModel.duration ?? 0)
        interviewEntity.interview_id = Int32(interviewModel.interviewId ?? 0)
        interviewEntity.interview_title = interviewModel.interviewTitle
        interviewEntity.interview_video_url_path = interviewModel.interviewURLPath
        
        //MARK:: Refer to Assessment Entity
        listAssessmentModel.forEach { model in
            let assessmentEntity = AssessmentEntity(context: taskContext)
            assessmentEntity.assessment_id = Int32(model.assessmentId ?? 0)
            assessmentEntity.assessment_question = model.assessmentQuestion
            
            //MARK:: Add Assessment Entity to Interview Entity
            interviewEntity.addToAssessments(assessmentEntity)
        }
       
        //MARK:: Refer to Score Type Entity
        listScoreTypeModel.forEach { model in
            let scoreEntity = ScoreTypeEntity(context: taskContext)
            scoreEntity.score_type_id = Int32(model.scoreTypeId ?? 0)
            scoreEntity.score_type_name = model.scoreTypeName
            scoreEntity.score_value = Int32(model.score ?? 0)
            
            //MARK:: Add Score Entity to Interview Entity
            interviewEntity.addToScores(scoreEntity)
        }
        
        
        do {
            try taskContext.save()
        } catch {
            print("Can't Save the data")
        }
        print("Interview Saved")
    }
    
    //MARK:: Get All Interview data from Interview Entity
    func getAllInterview()->[InterviewEntity] {
        var listInterviewEntity = [InterviewEntity]()
        do {
            listInterviewEntity = try context?.fetch(InterviewEntity.fetchRequest()) as! [InterviewEntity]
        } catch  {
            print("Can't get the Interview Data")
        }
        return listInterviewEntity
    }
    
    func getAllScores()->[ScoreTypeEntity] {
        var listInterviewEntity = [ScoreTypeEntity]()
        do {
            listInterviewEntity = try context?.fetch(ScoreTypeEntity.fetchRequest()) as! [ScoreTypeEntity]
        } catch  {
            print("Can't get the Interview Data")
        }
        return listInterviewEntity
    }
    
    func getAllQuestion()->[AssessmentEntity] {
        var listInterviewEntity = [AssessmentEntity]()
        do {
            listInterviewEntity = try context?.fetch(AssessmentEntity.fetchRequest()) as! [AssessmentEntity]
        } catch  {
            print("Can't get the Interview Data")
        }
        return listInterviewEntity
    }
}
