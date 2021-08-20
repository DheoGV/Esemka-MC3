//
//  SectionCollectionReusableView.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 20/08/21.
//

import UIKit

class SectionCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var sectionHeaderLbl: UILabel!
    
    static let identifier = "SectionCollectionReusableView"
    let dateFormatter = DateFormatter()
    
    var section: InterviewModel?{
        didSet{
            if let filled = section {
                dateFormatter.dateFormat = "MMMM"
                sectionHeaderLbl.text = dateFormatter.string(from: filled.interviewDate)
                //print(filled.interviewDate)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
