//
//  ScoreTableViewCell.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
static let identifer = "scorecell"
    @IBOutlet weak var lblScore: UILabel!
    
    static var nib: UINib {
        get {
            return UINib(nibName: "ScoreTableViewCell", bundle: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
