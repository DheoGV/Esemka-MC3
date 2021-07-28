//
//  VoiceSegregationExtension.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import Foundation

extension VoiceSegregetionViewController {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                self.labelClassify.text = identifier
                if identifier == "Interjection"{
                    self.interjection += 1
                    self.labelNumber.text = "Num : \(self.interjection)"
                }
            }
        }
    }
    func displayPredictionResult2(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if self.keepCounting{
                print(identifier)
            }
        }
    }
}
