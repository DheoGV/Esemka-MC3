//
//  BriefViewController.swift
//  Esmeka-MC3
//
//  Created by Anya Akbar on 27/07/21.
//

import UIKit

class BriefViewController: UIViewController {

    private var isChecked = false
    @IBOutlet weak var briefTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var ShowAgainSwitch: UISwitch!
    @IBOutlet weak var showAgainButton: UIButton!
    @IBAction func showAgainActionButton(_ sender: Any) {
        print(isChecked)
        isChecked = !isChecked
        guard  let switchOff = UIImage(named: "SwitchOff") else {
            return
        }
        guard  let switchOn = UIImage(named: "SwitchOn") else {
            return
        }
        if isChecked {
            showAgainButton.setImage(switchOn, for: UIControl.State.normal)
            showAgainButton.setImage(switchOn, for: UIControl.State.selected)
            showAgainButton.setImage(switchOn, for: UIControl.State.highlighted)
            
        } else {
            showAgainButton.setImage(switchOn, for: UIControl.State.normal)
            showAgainButton.setImage(switchOff, for: UIControl.State.selected)
            showAgainButton.setImage(switchOff, for: UIControl.State.highlighted)
            
        }
        print(isChecked)
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
        guard  let switchOff = UIImage(named: "SwitchOff") else {
            return
        }
        guard  let switchOn = UIImage(named: "SwitchOn") else {
            return
        }
        
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
