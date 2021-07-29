//
//  CompleteViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 27/07/21.
//

import UIKit
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

}
