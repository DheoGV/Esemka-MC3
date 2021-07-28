//
//  BriefCell.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 27/07/21.
//

import UIKit

class BriefCell: UITableViewCell {
static let identifier = "BriefCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    static var nib: UINib {
        get {
            return UINib(nibName: "BriefCell", bundle: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setView() {
        titleLabel.font =  UIFont.boldSystemFont(ofSize: 17)
    }
    
}

