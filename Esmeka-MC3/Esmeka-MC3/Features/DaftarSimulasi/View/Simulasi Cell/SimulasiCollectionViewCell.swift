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
    
    static let identifier = "SimulasiCollectionViewCell"
    
    
    var simulasi: InterviewModel?{
        didSet{
            if let filled = simulasi{
                waktuSimulasiLbl.text = "Test AM "
                tanggalSimulasiLbl.text = "\(filled.interviewDate)"
                durasiSimulasiLbl.text = "\(filled.duration) Menit "
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

}
