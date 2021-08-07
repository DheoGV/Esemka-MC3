//
//  DaftarSimulasiViewController.swift
//  Esmeka-MC3
//
//  Created by Dheo Gildas Varian on 27/07/21.
//

import UIKit

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
        //setup()
        print(listInterviewData.count)
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
            print("HUA AA")
            collectionView.isHidden = true
        } else if listInterviewData.count > 0{
            imgNoData.isHidden = true
            noData1Lbl.isHidden = true
            noData2Lbl.isHidden = true
            print("HUA")
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
        listInterviewData = coredataProvider.getAllInterview()
        print("count nya bro \(listInterviewData)")
        if listInterviewData.count == 0 {
            print("Null")
        } else {
            listInterviewData.forEach { result in
                print("Scores Value", result.scores?.value(forKey: "score_value"))
                print("Scores Type Name", result.scores?.value(forKey: "score_type_name"))
                print("Date", result.interview_date)
                print("Duration", result.interview_duration)
                print("Interview id", result.interview_id)
                
                let interviewModel = InterviewModel(interviewId: Int(result.interview_id), duration: Int(result.interview_duration), interviewDate: result.interview_date!, interviewURLPath: result.interview_video_url_path!)
                
                simulasiData.append(interviewModel)
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
 
    
}

extension DaftarSimulasiViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simulasiData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulasiCollectionViewCell.identifier, for: indexPath) as! SimulasiCollectionViewCell
        cell.simulasi = self.simulasiData[indexPath.row]
        cell.layer.cornerRadius = 10
        
        cell.didClick = { [weak self] in
            let simulasiDetailVC = DetailPageViewController(nibName: "DetailPageViewController", bundle: nil)
            simulasiDetailVC.id = self!.simulasiData[indexPath.row].interviewId
            
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
