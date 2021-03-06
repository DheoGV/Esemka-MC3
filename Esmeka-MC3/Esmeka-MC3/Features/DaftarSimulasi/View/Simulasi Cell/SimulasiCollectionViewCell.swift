//
//  SimulasiCollectionViewCell.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 28/07/21.
//

import UIKit
import Photos
import AVFoundation

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
                timeFormatter.dateFormat = "hh a"
                waktuSimulasiLbl.text = timeFormatter.string(from: filled.interviewDate)
                dateFormatter.dateStyle = .long
                tanggalSimulasiLbl.text = dateFormatter.string(from: filled.interviewDate)
                durasiSimulasiLbl.text = "\(filled.duration) Menit "
                //masih dummy thumbnail
             //   imageSimulasi.image = getThumbnail(asset: VideoFetchClass().loadLastVideo())
                
                //Teddy Test Image
                
                guard let interviewVideoURL = simulasi?.interviewURL else {return}
            
                if let thumbnailImage = getThumbnailImage(forUrl: interviewVideoURL) {
                        imageSimulasi.image = thumbnailImage
                }
                
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
    private func getThumbnail(asset:PHAsset)->UIImage{
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail =  UIImage()
        option.isSynchronous = true
        option .isNetworkAccessAllowed = true
        manager.requestImage(for: asset, targetSize: CGSize(width: viewSimulasiCell.frame.width , height: viewSimulasiCell.frame.width), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        
        return thumbnail
    }
    
    private func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }

}
