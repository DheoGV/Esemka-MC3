//
//  CompleteViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 27/07/21.
//

import UIKit

protocol DataSendingDelegateProtocol {
    func sendDataToDetailPage() //isi tipe data InterviewEntity
}

// MARK: - Complete View
class CompleteViewController: UIViewController {

    @IBOutlet weak var SimulationResultButton: UIButton!
    @IBOutlet weak var BackToSimulationListButton: UIButton!
    @IBOutlet weak var CongratulationLabel: UILabel!
    @IBOutlet weak var DetailCongratulationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    var delegate: DataSendingDelegateProtocol? = nil
    
    // customize view
    func setView() {
        CongratulationLabel.font = UIFont.boldSystemFont(ofSize: 22)
        DetailCongratulationLabel.font = UIFont.systemFont(ofSize: 17)
        SimulationResultButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        BackToSimulationListButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        SimulationResultButton.layer.cornerRadius = 25
        BackToSimulationListButton.layer.cornerRadius = 25
        BackToSimulationListButton.layer.borderColor = UIColor(red: 29/255, green: 52/255, blue: 158/255, alpha: 1).cgColor
        BackToSimulationListButton.layer.borderWidth = 1
        
    }

    
    //navigate
    
    @IBAction func backToSimulationlist(_sender: Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // delegate function waiting for clear database
    @IBAction func toSimulationResult(_sender: Any){
        if self.delegate != nil{
//            let dataToBeSent = //object Interview
//            self.delegate?.sendDataToDetailPage(myData: dataToBeSent!)
//            dismiss(animated: true, completion: nil)
        }
        let detailVC = DetailPageViewController(nibName: "DetailPageViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //receive data
}
