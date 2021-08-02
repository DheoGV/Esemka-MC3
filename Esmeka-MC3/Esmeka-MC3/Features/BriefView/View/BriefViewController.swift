//
//  BriefViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 27/07/21.
//

import UIKit

class BriefViewController: UIViewController {
    static let identifier = "BriefViewController"

    private var isChecked = false
    @IBOutlet weak var briefTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var ShowAgainSwitch: UISwitch!
    @IBOutlet weak var showAgainButton: UIButton!
    @IBAction func StartSimulationActionButton(_ sender: Any) {
        let simulationVc = InterviewSimulationViewController(nibName: InterviewSimulationViewController.identifier, bundle: nil)
        self.navigationController?.pushViewController(simulationVc, animated: true)
    }
    
    var briefInstructions : [BriefModel] = BriefModel.BriefData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }

    // MARK: - Setup View
    func setView() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        briefTable.register(BriefCell.nib, forCellReuseIdentifier: BriefCell.identifier)
        briefTable.dataSource = self
        briefTable.delegate = self
        briefTable.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 25
  
    }

}

extension BriefViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        briefInstructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = briefTable.dequeueReusableCell(withIdentifier: BriefCell.identifier) as! BriefCell
        
        cell.titleLabel.text = briefInstructions[indexPath.row].title
        cell.contentLabel.text = briefInstructions[indexPath.row].content
        return cell
    }
    
    
}
