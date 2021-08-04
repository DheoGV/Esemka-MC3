//
//  DaftarSimulasiViewController.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 27/07/21.
//

import UIKit

class DaftarSimulasiViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var noData1Lbl: UILabel!
    @IBOutlet weak var noData2Lbl: UILabel!
    
    var simulasiData: [InterviewModel]?
    let sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Daftar Simulasi"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchSimulasi()
        isSimulasiExist()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimulasiCollectionViewCell.nib(), forCellWithReuseIdentifier: SimulasiCollectionViewCell.identifier)
    }
    
    func fetchSimulasi() {
        simulasiData = SimulasiDataManager.shared.fetchSimulasi()
    }
    
    func isSimulasiExist(){
        if simulasiData?.count == 0 {
            imgNoData.isHidden = false
            noData1Lbl.isHidden = false
            noData2Lbl.isHidden = false
            collectionView.isHidden = true
        } else {
            collectionView.reloadData()
            imgNoData.isHidden = true
            noData1Lbl.isHidden = true
            noData2Lbl.isHidden = true
        }
    }
    
    @IBAction func simulasiButtonAction(_ sender: Any) {
        let briefVC = BriefViewController(nibName: "BriefViewController", bundle: nil)
        self.navigationController?.pushViewController(briefVC, animated: true)
    }
    
}

extension DaftarSimulasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simulasiData?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulasiCollectionViewCell.identifier, for: indexPath) as! SimulasiCollectionViewCell
        cell.simulasi = self.simulasiData?[indexPath.row]
        cell.layer.cornerRadius = 10
        
        cell.didClick = { [weak self] in
            let simulasiDetailVC = DetailPageViewController(nibName: "DetaiilPageViewController", bundle: nil)
            
            self?.navigationController?.pushViewController(simulasiDetailVC, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let space = sectionInset.left * 3
        let width = view.frame.width - space
        let widthPerItem = width / 2
        return CGSize(width: widthPerItem, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInset.left
    }
    
}
