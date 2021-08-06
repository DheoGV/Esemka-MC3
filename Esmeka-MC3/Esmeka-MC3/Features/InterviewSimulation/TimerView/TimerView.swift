//
//  TimerView.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 05/08/21.
//

import UIKit

class TimerView: UIView {
    @IBOutlet private var view:UIView!
    @IBOutlet private var countdown:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func loadViewFromNib(nibName:String)->UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func commonInit(){
        view = loadViewFromNib(nibName: "TimerView")
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        view.frame = self.bounds
        addSubview(view)
    }
    func setCounter(number:Int){
        countdown.text = "\(number)"
    }

}
