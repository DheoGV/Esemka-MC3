//
//  ResultObserver.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import Foundation


import Foundation
import UIKit
import SoundAnalysis


protocol SpeakClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double)
}


class ResultsObserver: NSObject, SNResultsObserving {
    var delegate: SpeakClassifierDelegate?
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        
        if confidence > 60 {
            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
        }
    }
}
