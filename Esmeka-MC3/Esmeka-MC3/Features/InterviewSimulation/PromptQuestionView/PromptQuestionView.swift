//
//  PromptQuestionView.swift
//  Esmeka-MC3
//
//  Created by Adhella Subalie on 29/07/21.
//

import UIKit

@IBDesignable class PromptQuestionView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet var pertanyaanInterviewTitle:UILabel!
    @IBOutlet var pertanyaanIsi:UILabel!
    @IBOutlet var indikatorPertanyaan:UILabel!
    @IBOutlet var nextButton:UIButton!

    
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
    
    override func prepareForInterfaceBuilder() {
        
    }
    
    func commonInit(){
        loadQuestions()
        view = loadViewFromNib(nibName: "PromptQuestionView")
        view.backgroundColor = bgColor
        view.layer.cornerRadius = cornerRadius
        view.alpha = 0.8
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        view.frame = self.bounds
        addSubview(view)
        setupTitle()
        setupIsi()
        setupIndicator()
        setupButton()
    }
    func setupTitle(){
        pertanyaanInterviewTitle.text = "Pertanyaan Interview"
        pertanyaanInterviewTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
    func setupIsi(){
        pertanyaanIsi.text = questions[currentQuestion-1]
    }
    func setupIndicator(){
        indikatorPertanyaan.text = "\(currentQuestion) dari \(totalQuestion)"
    }
    func setupButton() {
        nextButton.tintColor = UIColor.ColorLibrary.blueAccent
    }
    
    func loadQuestions(){
        questions = InterviewQuestionsSource().getQuestions()
        totalQuestion = InterviewQuestionsSource().getTotalQs()
    }
    
    @IBAction func next(_sender: UIButton){
        if self.currentQuestion <= self.totalQuestion {
            self.currentQuestion += 1
            if self.currentQuestion == self.totalQuestion{
                nextButton.isEnabled = false
            }
            setupIsi()
            setupIndicator()
        }else{
            //stop recording
        }
    }
    
    var bgColor: UIColor = .white
    var cornerRadius: CGFloat = 20
    var questions:[String] = []
    var currentQuestion = 1
    var totalQuestion = 6
    
    
}
