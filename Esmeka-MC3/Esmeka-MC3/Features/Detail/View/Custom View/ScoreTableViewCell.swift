//
//  ScoreTableViewCell.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

protocol ScoreProtocolDelegate: AnyObject {
    func changeIcon()
}

class ScoreTableViewCell: UITableViewCell {
static let identifer = "scorecell"
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblEkspresi: UILabel!
    @IBOutlet weak var lblDefaultPoint: UILabel!
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTextArea: UITextView!
    @IBOutlet weak var imageArrow: UIImageView!
    
    var delegate: ScoreProtocolDelegate?
    
    static var nib: UINib {
        get {
            return UINib(nibName: "ScoreTableViewCell", bundle: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        
    }
    private func setupView() {
        viewContainer.layer.cornerRadius = 10
        lblScore.textColor = .white
        lblEkspresi.textColor = .white
        lblDefaultPoint.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
