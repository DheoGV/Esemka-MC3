//
//  MyCollectionReusableView.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 19/08/21.
//

import UIKit

class MyCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerSectionLbl: UILabel!
    
    static let identifier = "MyCollectionReusableView"
    let dateFormatter = DateFormatter()
    
    var section: InterviewModel? {
        didSet{
            if let filled = section {
                dateFormatter.dateFormat = "LLLL"
                headerSectionLbl.text = dateFormatter.string(from: filled.interviewDate)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionReusableView", bundle: nil)
    }
    
}
