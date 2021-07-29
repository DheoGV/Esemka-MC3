//
//  ToggleButton.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 28/07/21.
//

import UIKit
@IBDesignable
class ToggleButton: UIButton {
    // MARK: - Variables
    private var fallingImage: UIImage?
    
    // MARK: - IBInspectable
    // Enable editing in IB to lessen coding inside Brief View Controller + make it reusable
    @IBInspectable var defaultImage: UIImage? {
        didSet {
            setImage(defaultImage, for: .normal)
        }
    }
    
    @IBInspectable var selectedImage: UIImage? {
        didSet {
            setImage(selectedImage, for: .selected)
        }
    }
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        isSelected = false
        addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap() {
        isSelected = !isSelected
        
        if isSelected {
            bounceAnimation()
            // Do core data handling here :
            
        }
    }
    //    Create animation as if the button is clicked : aka Bouncing
    private func bounceAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
            
            }, completion: { _ in
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                })
            })
        }
    }

}
