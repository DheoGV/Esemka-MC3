//
//  TimerRecordingView.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 18/08/21.
//

import UIKit

class TimerRecordingView: UIView {
  
    let view : UIView = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-60, y: UIScreen.main.bounds.height-170, width: 120, height: 50))
   
    
    let recordRed : UIView = {
       let redRound = UIView(frame: CGRect(x: 10, y: 15, width: 20, height: 20))
        redRound.layer.cornerRadius = 10
        redRound.backgroundColor = .red
        return redRound
    }()
    
    let label : UILabel = UILabel(frame: CGRect(x: 40, y: 15, width: 60, height: 20))

 
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal, cannot load view")
        
    }
    
    func setupView() {
        self.addSubview(setContentView())
    }
    
    func setContentView() -> UIView {
    view.backgroundColor = UIColor(white: 0, alpha: 0.2)
    view.layer.cornerRadius = 10
    label.textAlignment = NSTextAlignment.center
    label.font = UIFont(name: "Arial", size: 18)
    label.textColor = .white
    label.text = "00:00"
    view.addSubview(recordRed)
    view.addSubview(label)
    view.isHidden = true
    var runCount = 0
    var countToThree = 0
    //    var runTimer = true
    var fixTimer = ""
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        fixTimer = Int.asTimeString(runCount)()
        countToThree += 1
        if (countToThree >= 3) {
            self.view.isHidden = false
            runCount += 1
            self.label.text = "\(fixTimer )"
        }
        
        }
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            contentView.addSubview(view)
        
        return contentView
      
    }
    
}
