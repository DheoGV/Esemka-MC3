//
//  FaceEmotion.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 16/08/21.
//

import UIKit
import ARKit

class FaceEmotion {
    let model = try! VNCoreMLModel(for: FaceEmotionSentimentClassifier().model)
    var totalFaceEmotions = 0
    var goodEmotion = 0
    var faceEmotionScore:Int = 0
    
    func getFaceEmotionScore()->Int {
        var score = 0
        if goodEmotion > 0 {
            score = Int(goodEmotion * 100 / totalFaceEmotions)
        }
        return score
    }
}
