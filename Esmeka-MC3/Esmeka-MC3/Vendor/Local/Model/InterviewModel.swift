//
//  InterviewEntity.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 23/07/21.
//

import Foundation

struct InterviewModel {
    let interviewId: Int = 0
    let duration: Int = 0
    let interviewTitle: String = ""
    let interviewDate: Date?
    let interviewURLPath: String = ""
    let listAssessment: [AssessmentModel] = []
    let listScore: [ScoreTypeModel] = []
}
