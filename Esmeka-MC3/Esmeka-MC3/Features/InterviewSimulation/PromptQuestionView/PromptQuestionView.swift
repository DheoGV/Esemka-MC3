//
//  PromptQuestionView.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 29/07/21.
//

import UIKit

class PromptQuestionView: UIView {
    @IBOutlet weak var pertanyaanInterviewTitle:UILabel!
    @IBOutlet weak var pertanyaanIsi:UILabel!
    @IBOutlet weak var indikatorPertanyaan:UILabel!
    @IBOutlet weak var buttonSelanjutnya:UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupAll()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupAll()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
        setupTitle()
        setupIsi()
        setupIndicator()
        setupButton()
    }
    
    func setupAll(){
        setupView()
        setupTitle()
        setupIsi()
        setupIndicator()
        setupButton()
    }
    
    func setupView(){
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }
    func setupTitle(){
        pertanyaanInterviewTitle.text = "Pertanyaan Interview"
    }
    func setupIsi(){
        pertanyaanIsi.text = question
    }
    func setupIndicator(){
        indikatorPertanyaan.text = "\(currentQuestion) dari \(totalQuestion)"
    }
    func setupButton() {
        buttonSelanjutnya.backgroundColor = UIColor.ColorLibrary.blueAccent
    }
    
    @IBAction func next(_sender: UIButton){
        if self.currentQuestion <= self.totalQuestion {
            self.currentQuestion += 1
            if self.currentQuestion == self.totalQuestion{
                buttonSelanjutnya.isHidden = true
            }
        }else{
            //stop recording
        }
    }
    
    var bgColor: UIColor = .white
    var cornerRadius: CGFloat = 20
    var question = ""
    var currentQuestion = 1
    var totalQuestion = 6
    
    
}
