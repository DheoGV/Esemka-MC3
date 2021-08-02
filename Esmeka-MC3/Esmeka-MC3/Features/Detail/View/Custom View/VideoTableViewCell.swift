//
//  VideoTableViewCell.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit
protocol VideoProtocolDelegate: AnyObject {
    func playVideo()
}

class VideoTableViewCell: UITableViewCell {
    
    static let instance = VideoTableViewCell()

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var ivPlay: UIImageView!
    @IBOutlet weak var ivThumbail: UIImageView!
    @IBOutlet weak var lblVideo: UILabel!
    
    weak var videoDelegate: VideoProtocolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        ivPlay.isUserInteractionEnabled = true
        ivPlay.addGestureRecognizer(tap)
    }
    
    @objc func onTap(){
        videoDelegate?.playVideo()
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
