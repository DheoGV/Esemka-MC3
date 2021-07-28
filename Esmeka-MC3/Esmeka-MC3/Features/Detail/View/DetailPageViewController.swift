//
//  DetailPageViewController.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    @IBOutlet weak var tvDetail: UITableView!
    
    let sections:[String] = ["Nilai Simulasi", "Rekaman Simulasi"]
    let dataScore: [[String]] = [["80", "81", "82", "83", "84"]]
    let dataSimulasi:[[String]] = [["Cuma 1 HEHE"]]
    
    let dataScoreTest:[String] = ["HO", "HE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        tvDetail.dataSource = self
        tvDetail.delegate = self
        // Do any additional setup after loading the view.
       
    }
    
    private func registerTableView() {
        tvDetail.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "scorecell")
        
        tvDetail.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "videocell")
    }
}

extension DetailPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataScore[section].count
        case 1:
            return dataSimulasi[section-1].count
        default:
            return dataSimulasi.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "scorecell") as! ScoreTableViewCell
            print(dataScore[indexPath.section][indexPath.row])
            cell.lblScore.text = "HAHAHA"
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell") as! VideoTableViewCell
            cell.lblVideo.text = dataSimulasi[indexPath.section-1][indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell") as! VideoTableViewCell
            cell.lblVideo.text = dataSimulasi[indexPath.section][indexPath.row]
            
            return cell
        }
    }
    
}
