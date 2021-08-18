//
//  AssessmentEntity+CoreDataProperties.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 17/08/21.
//
//

import Foundation
import CoreData


extension AssessmentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssessmentEntity> {
        return NSFetchRequest<AssessmentEntity>(entityName: "AssessmentEntity")
    }

    @NSManaged public var assessment_id: Int32
    @NSManaged public var assessment_question: String?
    @NSManaged public var ofInterviewAssessment: InterviewEntity?

}

extension AssessmentEntity : Identifiable {

}
