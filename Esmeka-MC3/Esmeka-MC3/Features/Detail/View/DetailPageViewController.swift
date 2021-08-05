//
//  DetailPageViewController.swift
//  Esmeka-MC3
//
//  Created by Christopher Teddy  on 27/07/21.
//

import UIKit
import AVKit

struct Score {
    var score: Int?
    var colorCell: UIColor?
    var isCollapse: Bool?
    var scoreTypeName: String?
    var scoreExplanation: String?
}

struct Video {
    var imageURL: String
}

class DetailPageViewController: UIViewController{
    
    @IBOutlet weak var tvDetail: UITableView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    
    let dateCurrent = Date()
    
    let selectedIndex = -1
    
    let sections:[String] = ["Nilai Simulasi","","","", "Rekaman Simulasi"]
//    var dataScore3: [[Score]] = [[
//                                    Score(score: 81, colorCell: UIColor(red: 0.11, green: 0.44, blue: 0.53, alpha: 1.00), isCollapse: false, scoreTypeName: "a")],
//                                 [
//                                    Score(score: 82, colorCell: UIColor(red: 0.28, green: 0.20, blue: 0.83, alpha: 1.00), isCollapse:  false, scoreTypeName: "a")],
//                                 [
//                                    Score(score: 83, colorCell: UIColor(red: 0.20, green: 0.29, blue: 0.37, alpha: 1.00), isCollapse: false, scoreTypeName: "a"),],
//                                 [
//                                    Score(score: 84, colorCell: UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.00), isCollapse: false, scoreTypeName: "a"),],
//    ]
    var dataScore3 : [[Score]] = [[]]
    var scores: [Score] = []
    
    
    let dataSimulasi:[[Video]] = [[Video(imageURL: "gambar")]]
    
    private lazy var coredataProvider: CoredataProvider = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return CoredataProvider(appDelegate)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getScoresByInterviewId(interviewId: 1)
        getSingleInterviewId(interviewId: 1)
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
    
    
    private func getScoresByInterviewId(interviewId: Int) {
        //MARK:: Example How to Get Scores by Single Interview
        
        let scoresInterview = coredataProvider.getScoresByInteviewId(interviewId: interviewId)
        scoresInterview.forEach { score in
            print("Score Type Name", score.value(forKey: "score_type_name") as! String)
            var scoreTypeName = score.value(forKey: "score_type_name") as! String
            var scoreValue = score.value(forKey: "score_value") as! Int
        
            
            print("Score Type name \(scoreTypeName) Score Value \(scoreValue)")
            
            let score = Score(score: scoreValue, colorCell:  UIColor(red: 0.11, green: 0.44, blue: 0.53, alpha: 1.00), isCollapse: false, scoreTypeName: scoreTypeName, scoreExplanation: "HEHE")
            
            print("Nilai ", score)
            scores.append(score)
            print("Nilai 1", scores[0])
            
            //Crash disini
            print("Nilai 1", scores[1])
            
            print("Count", scores.count)
           
            dataScore3.append(scores)
            print("Hitung 2", dataScore3.count)
        }
    }
    
    private func getSingleInterviewId(interviewId: Int) {
        let interview = coredataProvider.getSingleInterview(interviewId: interviewId)
        var date = interview.value(forKey: "interview_date")!
        lblDate.text = "\(date)"
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
            let scoreTypeName = dataScore3[indexPath.section][indexPath.row].scoreTypeName!
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.lblEkspresi.text = "\(String(describing: scoreTypeName))"
            cell.viewContainer.backgroundColor = uiColor
            
            
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            let scoreTypeName = dataScore3[indexPath.section][indexPath.row].scoreTypeName!
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.lblEkspresi.text = "\(String(describing: scoreTypeName))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            let scoreTypeName = dataScore3[indexPath.section][indexPath.row].scoreTypeName!
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.lblEkspresi.text = "\(String(describing: scoreTypeName))"
            cell.viewContainer.backgroundColor = uiColor
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifer) as! ScoreTableViewCell
            let score = dataScore3[indexPath.section][indexPath.row].score!
            let uiColor = dataScore3[indexPath.section][indexPath.row].colorCell
            let scoreTypeName = dataScore3[indexPath.section][indexPath.row].scoreTypeName!
            
            print(indexPath.section)
            
            cell.lblScore.text = "\(String(describing: score))"
            cell.lblEkspresi.text = "\(String(describing: scoreTypeName))"
            cell.viewContainer.backgroundColor = uiColor
            
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videocell") as! VideoTableViewCell
            cell.ivThumbail.image = UIImage(named: dataSimulasi[0][indexPath.row].imageURL)
            cell.videoDelegate = self
            
            
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
        //        if ( indexPath.section == 4) {
        //            return 190
        //        } else {
        //            return 90
        //        }
        //
        switch indexPath.section {
        case 0:
            if dataScore3[0][indexPath.row].isCollapse == true {
                return 150
            } else{
                return 90
            }
        case 1 :
            if dataScore3[1][indexPath.row].isCollapse == true {
                return 150
            } else{
                return 90
            }
        case 2 :
            if dataScore3[2][indexPath.row].isCollapse == true {
                return 150
            } else{
                return 90
            }
        case 3 :
            if dataScore3[3][indexPath.row].isCollapse == true {
                return 150
            } else{
                return 90
            }
        case 4 :
            return 190
        default:
            return 60
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tvDetail.deselectRow(at: indexPath, animated: true)
            
            if dataScore3[0][indexPath.row].isCollapse == false {
                self.dataScore3[0][indexPath.row].isCollapse = !self.dataScore3[0][indexPath.row].isCollapse!
            } else {
                self.dataScore3[0][indexPath.row].isCollapse = false
            }
            
            // self.selectedIndex = indexPath.row
            tvDetail.reloadRows(at: [indexPath], with: .automatic)
            
            
            
        case 1:
            tvDetail.deselectRow(at: indexPath, animated: true)
            
            if dataScore3[1][indexPath.row].isCollapse == false {
                self.dataScore3[1][indexPath.row].isCollapse = !self.dataScore3[1][indexPath.row].isCollapse!
            } else {
                self.dataScore3[1][indexPath.row].isCollapse = false
            }
            
            // self.selectedIndex = indexPath.row
            tvDetail.reloadRows(at: [indexPath], with: .automatic)
        case 2 :
            tvDetail.deselectRow(at: indexPath, animated: true)
            
            if dataScore3[2][indexPath.row].isCollapse == false {
                self.dataScore3[2][indexPath.row].isCollapse = !self.dataScore3[2][indexPath.row].isCollapse!
            } else {
                self.dataScore3[2][indexPath.row].isCollapse = false
            }
            
            // self.selectedIndex = indexPath.row
            tvDetail.reloadRows(at: [indexPath], with: .automatic)
        case 3 :
            tvDetail.deselectRow(at: indexPath, animated: true)
            
            if dataScore3[3][indexPath.row].isCollapse == false {
                self.dataScore3[3][indexPath.row].isCollapse = !self.dataScore3[3][indexPath.row].isCollapse!
            } else {
                self.dataScore3[3][indexPath.row].isCollapse = false
            }
            
            // self.selectedIndex = indexPath.row
            tvDetail.reloadRows(at: [indexPath], with: .automatic)
        default :
            print("ASD")
        }
    }
    
}

extension DetailPageViewController : VideoProtocolDelegate {
    func playVideo() {
        print("TEST")
        if let path = Bundle.main.path(forResource: "s1c1", ofType: "mp4") {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayerController = AVPlayerViewController()
            videoPlayerController.player = video
            
            present(videoPlayerController, animated: true) {
                video.play()
            }
        }
    }
}

extension DetailPageViewController: DataSendingDelegateProtocol{
    //function from protocoldelegate
    func sendDataToDetailPage() {
        //
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "getDataSegue" {
        //            let secondVC: SecondViewController = segue.destination as! SecondViewController
        //            secondVC.delegate = self
        //        }
    }
    
}

