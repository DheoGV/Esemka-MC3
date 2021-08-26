//
//  StartSimulationInterface.swift
//  Esemka-WatchKit WatchKit Extension
//
//  Created by Anya Akbar on 26/08/21.
//

import WatchKit
import Foundation

class StartSimulationInterface: WKInterfaceController {

    @IBOutlet weak var startGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        startGroup.setCornerRadius(70)
        
    }
}
