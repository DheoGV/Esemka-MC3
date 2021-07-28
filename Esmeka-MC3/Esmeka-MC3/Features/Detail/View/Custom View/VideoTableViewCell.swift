//
//  VideoTableViewCell.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var ivPlay: UIImageView!
    @IBOutlet weak var ivThumbail: UIImageView!
    @IBOutlet weak var lblVideo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        videoContainerView.layer.cornerRadius = 10
        videoContainerView.backgroundColor = .white
        
    }
    
}
