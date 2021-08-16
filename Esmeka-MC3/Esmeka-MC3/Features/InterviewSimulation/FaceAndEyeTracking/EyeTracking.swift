//
//  EyeTracking.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 16/08/21.
//

import UIKit
import ARKit

class EyeTracking{
    
    var listOfCoordinate:[Coordinate] = []
    var listOfCoordinateTemp:[Coordinate] = []
    var countFrameRenderer = 0
    let globalQueue = DispatchQueue.global(qos: .default)
    var countMiss = 0
    var countMissInSecond = 0
    var countMissFrameRenderer = 0
    var resultValueEye = 100
    var tempResult = 0.0
    
    func getEyeTrackingScore()->Int {
        var score = 0
        score = resultValueEye - countMiss
        return score
    }
}

