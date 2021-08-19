//
//  DaftarSimulasiViewController.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 27/07/21.
//

import UIKit
import Photos

class DaftarSimulasiViewController: UIViewController {
    
    
    //MARK:: Make Lazy for single isntance only, it prevent memory leak
    private lazy var coredataProvider: CoredataProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return CoredataProvider(appDelegate)
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var noData1Lbl: UILabel!
    @IBOutlet weak var noData2Lbl: UILabel!
    
    var simulasiData = [InterviewModel]()
    let sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let userDefault = UserDefaults.standard
    
    
    var listInterviewData = [InterviewEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    
    
    func setup() {
        title = "Daftar Simulasi"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //MARK:: Ted
        getAllInterview()
        isSimulationDataExists()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimulasiCollectionViewCell.nib(), forCellWithReuseIdentifier: SimulasiCollectionViewCell.identifier)
    }
    
    //MARK:: Ted
    func isSimulationDataExists() {
        if listInterviewData.count == 0 {
            imgNoData.isHidden = false
            noData1Lbl.isHidden = false
            noData2Lbl.isHidden = false
            collectionView.isHidden = true
        } else if listInterviewData.count > 0{
            imgNoData.isHidden = true
            noData1Lbl.isHidden = true
            noData2Lbl.isHidden = true
            collectionView.reloadData()
        }
    }
    
    @IBAction func simulasiButtonAction(_ sender: Any) {
        let readBriefSetting = userDefault.object(forKey: "showBrief") as? Bool ?? true
        
        if(readBriefSetting){
            goToBriefView()
        } else {
            goToSimulation()
        }
        
    }
    
    func goToBriefView() {
        let briefVC = BriefViewController(nibName: "BriefViewController", bundle: nil)
        self.navigationController?.pushViewController(briefVC, animated: true)
    }
    func goToSimulation()  {
        let simulationVC = InterviewSimulationViewController(nibName: "InterviewSimulationViewController", bundle: nil)
        navigationController?.pushViewController(simulationVC, animated: true)
    }
    
    //MARK::Example Get All the interview
    private func getAllInterview(){
        simulasiData = []
        listInterviewData = coredataProvider.getAllInterview()
        print("count nya bro \(listInterviewData)")
        if listInterviewData.count == 0 {
            print("Null")
        } else {
            listInterviewData.forEach { result in                
                if result.interview_video_url_path != nil {
                    guard let interviewVideoURL = result.interview_video_url_path, let interviewVideoURLLink = result.interview_video_url_link else {
                        return
                    }
                    let interviewModel = InterviewModel(interviewId: Int(result.interview_id), duration: Int(result.interview_duration), interviewDate: result.interview_date!, interviewURLPath: interviewVideoURL, interviewURL: interviewVideoURLLink)
                    
                    print("URL Data", interviewVideoURL)
                    print("URL type URL", interviewVideoURLLink)
                    
                   simulasiData.append(interviewModel)
                    self.collectionView.reloadData()
                }
            }
            
            let listScoresEntity = coredataProvider.getAllScores()
            
            listScoresEntity.forEach { score in
                print("Score", score)
            }
            
            let listQuestion = coredataProvider.getAllQuestion()
            
            listQuestion.forEach { score in
                print("Question", score)
            }
        }
    }
    
    private func writeVideoToLibrary(url: URL) {
        // write data to library camera roll
        PHPhotoLibrary.shared().performChanges({
            let phAsset = PHAsset()
            let changeRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            print("Success Changes")
            /*
             let manager = PHImageManager.default()
             let option = PHImageRequestOptions()
             var thumbnail =  UIImage()
             option.isSynchronous = true
             option .isNetworkAccessAllowed = true
             manager.requestImage(for: self, targetSize: CGSize(width: 100 , height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
             thumbnail = result!
             })
             */
            
            let contentEditing = changeRequest?.contentEditingOutput
            
        }) { saved, err in
            if err != nil {
                print(err.debugDescription)
            }
        }
    }
    
    func toggleFavorite(for asset: PHAsset) {
        PHPhotoLibrary.shared().performChanges {
            // Create a change request from the asset to be modified.
            let request = PHAssetChangeRequest(for: asset)
            // Set a property of the request to change the asset itself.
            request.isFavorite = !asset.isFavorite
        } completionHandler: { success, error in
            print("Finished updating asset. " + (success ? "Success." : error!.localizedDescription))
        }
    }
}

extension DaftarSimulasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listInterviewData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulasiCollectionViewCell.identifier, for: indexPath) as? SimulasiCollectionViewCell else { fatalError() }
        cell.simulasi = self.simulasiData[indexPath.row]
        cell.layer.cornerRadius = 10
        
        cell.didClick = { [weak self] in
            
            let simulasiDetailVC = DetailPageViewController(nibName: "DetailPageViewController", bundle: nil)
            simulasiDetailVC.id = self?.simulasiData[indexPath.row].interviewId
            
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
