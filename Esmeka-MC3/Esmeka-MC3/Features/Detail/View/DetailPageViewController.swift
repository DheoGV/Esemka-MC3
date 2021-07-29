//
//  DetailPageViewController.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit

struct Score {
    var score: Int?
    var colorCell: UIColor?
}

struct Video {
    var imageURL: String
}

class DetailPageViewController: UIViewController {
    
    @IBOutlet weak var tvDetail: UITableView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    
    let dateCurrent = Date()

    let sections:[String] = ["Nilai Simulasi","","","", "Rekaman Simulasi"]
    let dataScore3: [[Score]] = [[
                                    Score(score: 81, colorCell: UIColor(red: 0.11, green: 0.44, blue: 0.53, alpha: 1.00))],
                                 [
                                    Score(score: 82, colorCell: UIColor(red: 0.28, green: 0.20, blue: 0.83, alpha: 1.00))],
                                 [
                                    Score(score: 83, colorCell: UIColor(red: 0.20, green: 0.29, blue: 0.37, alpha: 1.00)),],
                                 [
                                    Score(score: 84, colorCell: UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.00)),],
    ]
    
    let dataSimulasi:[[Video]] = [[Video(imageURL: "gambar")]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        registerTableView()
        tvDetail.dataSource = self
        tvDetail.delegate = self
        tvDetail.layer.cornerRadius = 10
        tvDetail.layer.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00).cgColor
        lblDate.text = dateCurrent.description
        
        btnFinish.layer.cornerRadius = 10
        btnFinish.backgroundColor = UIColor(red: 0.08, green: 0.20, blue: 0.64, alpha: 1.00)
        tvDetail.showsVerticalScrollIndicator = false
    }
    
    private func registerTableView() {
        tvDetail.register(ScoreTableViewCell.nib, forCellReuseIdentifier: ScoreTableViewCell.identifer)
        
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
            return dataScore3[section].count
        case 1:
            return dataSimulasi[0].count
        default:
            return dataSimulasi.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            cell.lblScore.text = "\(String(describing: score))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell") as! VideoTableViewCell
            cell.ivThumbail.image = UIImage(named: dataSimulasi[0][indexPath.row].imageURL)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell") as! VideoTableViewCell
            cell.ivThumbail.image = UIImage(named: dataSimulasi[0][indexPath.row].imageURL)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100)) //set these values as necessary
        returnedView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        
        let label = UILabel(frame: CGRect(x: 2, y: 0, width: 200, height: 20))
        
        label.text = self.sections[section]
        label.font = label.font.withSize(22)
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 12
        } else {
            return 24
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ( indexPath.section == 4) {
            return 190
        } else {
            return 90
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tvDetail.frame.size.width, height: 0))
            footerView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
            return footerView
        } else {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tvDetail.frame.size.width, height: 0))
            footerView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)

            return footerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 7
        } else {
            return  3
        }
    }
   
}
