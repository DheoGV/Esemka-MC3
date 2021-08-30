//
//  BriefCollectionViewCell.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 30/08/21.
//

import UIKit


class BriefCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var briefImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    static let identifier = String(describing: BriefCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ slide: SlideBrief){
        briefImg.image = slide.briefImage
        titleLbl.text = slide.title
        subTitleLbl.text = slide.subTitle
    }

}
