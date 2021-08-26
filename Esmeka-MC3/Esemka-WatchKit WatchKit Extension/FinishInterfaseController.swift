//
//  FinishInterfaseController.swift
//  Esemka-WatchKit WatchKit Extension
//
//  Created by Anya Akbar on 26/08/21.
//

import WatchKit
import Foundation

class FinishInterfaseController: WKInterfaceController {

    @IBOutlet weak var finishGroup: WKInterfaceGroup!
    override func awake(withContext context: Any?) {
        finishGroup.setCornerRadius(70)
    }
}
