//
//  CustomButton.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

@IBDesignable class CustomButton: UIView {
    
    @IBOutlet weak var textButton: UILabel!
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
    
    func setupButton() {
        self.backgroundColor = color
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    var color: UIColor = UIColor(red: 0.08, green: 0.20, blue: 0.64, alpha: 1.00)
    var cornerRadius: CGFloat = 20
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .white
    
}
