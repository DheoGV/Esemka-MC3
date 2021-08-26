//
//  QuestionCountsInterfaceController.swift
//  Esemka-WatchKit WatchKit Extension
//
//  Created by Anya Akbar on 26/08/21.
//

import WatchKit
import Foundation

class QuestionCountsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var questionGroup: WKInterfaceGroup!
    override func awake(withContext context: Any?) {
        questionGroup.setCornerRadius(70)
    }

}
