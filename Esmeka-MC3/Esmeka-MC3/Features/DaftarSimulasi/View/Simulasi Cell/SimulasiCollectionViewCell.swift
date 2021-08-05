//
//  SimulasiCollectionViewCell.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 28/07/21.
//

import UIKit

class SimulasiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewSimulasiCell: UIView!
    @IBOutlet weak var imageSimulasi: UIImageView!
    @IBOutlet weak var waktuSimulasiLbl: UILabel!
    @IBOutlet weak var tanggalSimulasiLbl: UILabel!
    @IBOutlet weak var durasiSimulasiLbl: UILabel!
    
    var didClick: (() -> ())?
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    static let identifier = "SimulasiCollectionViewCell"
    
    
    var simulasi: InterviewModel?{
        didSet{
            if let filled = simulasi{
                timeFormatter.dateStyle = .short
                waktuSimulasiLbl.text = timeFormatter.string(from: filled.interviewDate)
                dateFormatter.dateStyle = .long
                tanggalSimulasiLbl.text = dateFormatter.string(from: filled.interviewDate)
                durasiSimulasiLbl.text = "\(filled.duration) Menit "
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.simulasiPressed(_:)))
                viewSimulasiCell.addGestureRecognizer(tap)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SimulasiCollectionViewCell", bundle: nil)
    }
    
    @objc func simulasiPressed(_: UITapGestureRecognizer) {
        didClick?()
    }

}
