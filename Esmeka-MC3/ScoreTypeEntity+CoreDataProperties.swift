//
//  ScoreTypeEntity+CoreDataProperties.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 04/08/21.
//
//

import Foundation
import CoreData


extension ScoreTypeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreTypeEntity> {
        return NSFetchRequest<ScoreTypeEntity>(entityName: "ScoreTypeEntity")
    }

    @NSManaged public var score_type_name: String?
    @NSManaged public var score_value: Int32
    @NSManaged public var ofInterviewScores: InterviewEntity?

}

extension ScoreTypeEntity : Identifiable {

}
