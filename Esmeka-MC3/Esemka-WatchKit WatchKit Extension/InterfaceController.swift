//
//  InterfaceController.swift
//  Esemka-WatchKit WatchKit Extension
//
//  Created by Christopher Teddy  on 24/08/21.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lblFlipCoin: WKInterfaceLabel!
    @IBOutlet weak var buttonTest: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    @IBAction func btnTest() {
        lblFlipCoin.setText("Flipping the coin...")
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.lblFlipCoin.setText("Flipping the coin...")
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                let randomFlip = Bool.random()
                if (randomFlip) {
                    self.lblFlipCoin.setText("Head")
                } else {
                    self.lblFlipCoin.setText("Tail")
                }
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
