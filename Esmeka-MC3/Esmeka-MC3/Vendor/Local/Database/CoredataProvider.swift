//
//  CoredataProvider.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 23/07/21.
//

import Foundation
import CoreData
import Photos

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
        interviewEntity.interview_duration = Int32(interviewModel.duration)
        interviewEntity.interview_video_url_path = interviewModel.interviewURLPath
        interviewEntity.interview_id = Int32(interviewModel.interviewId)
        interviewEntity.interview_video_url_link = interviewModel.interviewURL
        
        
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
            scoreEntity.score_type_name = model.scoreTypeName?.rawValue
            scoreEntity.score_value = Int32(model.score ?? 0)
            
            //MARK:: Add Score Entity to Interview Entity
            interviewEntity.addToScores(scoreEntity)
        }
        
        
        do {
            try taskContext.save()
            print("Interview Saved")
        } catch {
            print("Can't Save the data")
        }
        
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
    
    //MARK:: Get SingleInterviewEntity
    func getSingleInterview(interviewId: Int)->InterviewEntity {
        var interviewEntity: InterviewEntity?
        let interviewEntityResult: [InterviewEntity]?
        do {
            let fetchRequest : NSFetchRequest<InterviewEntity> = InterviewEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "(interview_id == %d)", interviewId)
            interviewEntityResult = try context?.fetch(fetchRequest)
            
            if let singleInterviewEntity = interviewEntityResult?.first {
                interviewEntity = singleInterviewEntity
            }
        } catch {
            print("Can't get scores by interview data")
        }
        
        return interviewEntity ?? InterviewEntity()
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
    
    //need this function untuk ambil ScoreTypeEntity yang berhubungan dengan sebuah InterviewModel
    func getScoresWhereInterviewEntityIs(interview:InterviewModel)->[ScoreTypeEntity]{
        let listInterviewEntity = [ScoreTypeEntity]()
        
        
        return listInterviewEntity
    }
    
    //MARK:: Call Single Interviewentity
    func getScoresByInteviewId(interviewId: Int) -> [ScoreTypeEntity] {
        var listScoresEntity = [ScoreTypeEntity]()
        let interviewEntityResult: [InterviewEntity]?
        do {
            let fetchRequest : NSFetchRequest<InterviewEntity> = InterviewEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "(interview_id == %d)", interviewId)
            interviewEntityResult = try context?.fetch(fetchRequest)
            
            if let singleInterviewEntity = interviewEntityResult?.first {
                let scores = singleInterviewEntity.scores?.allObjects as! [ScoreTypeEntity]
                scores.forEach { score in
                    listScoresEntity.append(score)
                    
                }
            }
            
            
            
        } catch {
            print("Can't get scores by interview data")
        }
        return listScoresEntity
    }
    
    //MARK:: Delete Single Interview
    func deleteSingleInterview(interviewId: Int) {
     //   var interviewEntity: InterviewEntity?
        let interviewEntityResult: [InterviewEntity]?
        
        guard let taskContext = context else {
            return
        }
      //  interviewEntity = InterviewEntity(context: taskContext)
        do {
            let fetchRequest:NSFetchRequest<InterviewEntity> = InterviewEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "(interview_id == %d)", interviewId)
            
            interviewEntityResult = try context?.fetch(fetchRequest)
            for data in interviewEntityResult! {
                context?.delete(data)
            }
            try context?.save()
            
        } catch {
            print("Not Found")
        }
    }
}
