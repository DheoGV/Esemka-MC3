//
//  VoiceSegregationExtension.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 26/07/21.
//

import Foundation

extension VoiceSegregetionViewController : SpeakClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if identifier == "Interjection" && self.keepCounting{
                self.labelClassify.text = "Interjection"
                self.interjection += 1
                self.labelNumber.text = "Num : \(self.interjection)"
            }
            
            if identifier == "Speak" && self.keepCounting{
                self.labelClassify.text = "Speaking"
            }
            
            if identifier == "Noise" && self.keepCounting {
                self.labelClassify.text = "Noise"
               
            }
            if self.keepCounting == false {
            
            }
        }
    }
}
