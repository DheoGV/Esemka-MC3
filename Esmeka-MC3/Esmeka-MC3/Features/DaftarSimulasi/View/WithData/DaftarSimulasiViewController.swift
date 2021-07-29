//
//  DaftarSimulasiViewController.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 27/07/21.
//

import UIKit

class DaftarSimulasiViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Daftar Simulasi"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimulasiCollectionViewCell.nib(), forCellWithReuseIdentifier: SimulasiCollectionViewCell.identifier)
    }
}

extension DaftarSimulasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulasiCollectionViewCell.identifier, for: indexPath) as! SimulasiCollectionViewCell
       // cell.simulasi = SimulasiData.simulasi[indexPath.row]
        cell.layer.cornerRadius = 10
        
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
