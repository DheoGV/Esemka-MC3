//
//  InterviewEntity+CoreDataProperties.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 07/08/21.
//
//

import Foundation
import CoreData


extension InterviewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InterviewEntity> {
        return NSFetchRequest<InterviewEntity>(entityName: "InterviewEntity")
    }

    @NSManaged public var interview_date: Date?
    @NSManaged public var interview_duration: Int32
    @NSManaged public var interview_id: Int32
    @NSManaged public var interview_video_url_path: Data?
    @NSManaged public var assessments: NSSet?
    @NSManaged public var scores: NSSet?

}

// MARK: Generated accessors for assessments
extension InterviewEntity {

    @objc(addAssessmentsObject:)
    @NSManaged public func addToAssessments(_ value: AssessmentEntity)

    @objc(removeAssessmentsObject:)
    @NSManaged public func removeFromAssessments(_ value: AssessmentEntity)

    @objc(addAssessments:)
    @NSManaged public func addToAssessments(_ values: NSSet)

    @objc(removeAssessments:)
    @NSManaged public func removeFromAssessments(_ values: NSSet)

}

// MARK: Generated accessors for scores
extension InterviewEntity {

    @objc(addScoresObject:)
    @NSManaged public func addToScores(_ value: ScoreTypeEntity)

    @objc(removeScoresObject:)
    @NSManaged public func removeFromScores(_ value: ScoreTypeEntity)

    @objc(addScores:)
    @NSManaged public func addToScores(_ values: NSSet)

    @objc(removeScores:)
    @NSManaged public func removeFromScores(_ values: NSSet)

}

extension InterviewEntity : Identifiable {

}
