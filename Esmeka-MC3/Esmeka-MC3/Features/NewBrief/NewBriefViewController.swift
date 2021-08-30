//
//  NewBriefViewController.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 30/08/21.
//

import UIKit

class NewBriefViewController: UIViewController {

    @IBAction func DontShowAgainAction(_ sender: Any) {
        userDefault.setValue(false, forKey: "showBrief")
    }
    @IBOutlet weak var CustomStartView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var StartNowButton: UIButton!
    @IBAction func StartNowAction(_ sender: Any) {
        goToSimulation()
    }
    
    
    func goToSimulation()  {
        let simulationVC = InterviewSimulationViewController(nibName: "InterviewSimulationViewController", bundle: nil)
    navigationController?.pushViewController(simulationVC, animated: true)
    }
    
    let userDefault = UserDefaults.standard
    let cellIdentifier = "BriefCollectionViewCell"
    var slides: [SlideBrief] = []
    var currentPage = 0 {
        didSet{
            if currentPage == slides.count - 1 {
                CustomStartView.isHidden = false
         
            } else {
                CustomStartView.isHidden = true
            
            }
            print(currentPage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup(){
        title = "Persiapan simulasi"
        CustomStartView.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BriefCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        //button id hidden = true
        StartNowButton.layer.cornerRadius = 20
        
        slides = [
            SlideBrief(briefImage: UIImage(named: "illustration_brief_satu") ?? UIImage(), title: "Tata Krama dan Bahasa Tubuh", subTitle: "Berpakaianlah dengan rapi dan menjaga postur tubuh dengan duduk tegak menghadap kamera."),
            SlideBrief(briefImage: UIImage(named: "illustration_brief_dua") ?? UIImage(), title: "Ekspresi Wajah dan Kontak Mata", subTitle: "Pastikan posisi mata sejajar dengan lensa kamera dan tersenyumlah saat proses wawancara."),
            SlideBrief(briefImage: UIImage(named: "illustration_brief_tiga") ?? UIImage(), title: "Paralinguistik", subTitle: "Perhatikan volume dan kecepatan berbicara saat proses wawancara dan minimalisir penggunaan uhm, ee, uh, ah")
        ]
    }



}

extension NewBriefViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BriefCollectionViewCell.identifier, for: indexPath) as? BriefCollectionViewCell else { fatalError() }
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        return CGSize(width: width , height: height - 400)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
        self.currentPage = currentPage
    }
    
    
}
