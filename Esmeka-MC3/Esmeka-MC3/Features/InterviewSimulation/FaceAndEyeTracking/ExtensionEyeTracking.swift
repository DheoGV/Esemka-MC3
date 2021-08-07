//
//  ExtensionEyeTracking.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 06/08/21.
//

import Foundation

extension InterviewSimulationViewController {
    func countEyeTrackingMiss() {
        if (timerTimeNow != 0 && countMissInSecond != 0) {
            //resultValueEye = Int(timerTimeNow) / countMissInSecond
            tempResult = (Double(countMissInSecond) / timerTimeNow) * 100
            print("Temp Result", tempResult)
            resultValueEye = Int(100 - tempResult)
            print("Result Value Eye Score", resultValueEye)
        }
       
        print("Total Timer Now", timerTimeNow)
        print("Total Timer miss", countMissInSecond)
        
    }
}