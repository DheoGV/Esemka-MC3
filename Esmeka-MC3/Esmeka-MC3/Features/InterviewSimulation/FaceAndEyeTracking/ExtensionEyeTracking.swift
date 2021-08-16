//
//  ExtensionEyeTracking.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 06/08/21.
//

import Foundation

extension InterviewSimulationViewController {
    func countEyeTrackingMiss() {
        if (voiceEngine.timerTimeNow != 0 && eyeTracking.countMissInSecond != 0) {
            //resultValueEye = Int(timerTimeNow) / countMissInSecond
            eyeTracking.tempResult = (Double(eyeTracking.countMissInSecond) / voiceEngine.timerTimeNow) * 100
            eyeTracking.resultValueEye = Int(100 - eyeTracking.tempResult)
        }
    }
}
