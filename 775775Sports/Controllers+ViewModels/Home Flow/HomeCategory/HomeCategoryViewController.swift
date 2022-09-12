//
//  HomeCategoryViewController.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import UIKit

enum HomeCategory{
    case index
    case analysis
    case league
    case event
    case animation
    case live
}

class HomeCategoryViewController: BaseViewController {
    //MARK: - IBOutlets
    //TopView outlets starts
    @IBOutlet weak var viewIndex: UIView!
    
    @IBOutlet weak var viewAnalysis: UIView!
    
    @IBOutlet weak var viewLeague: UIView!
    
    @IBOutlet weak var viewEvent: UIView!
    
    @IBOutlet weak var viewBriefing: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblHomeName: UILabel!
    
    @IBOutlet weak var lblAwayName: UILabel!
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHalfScore: UILabel!
    @IBOutlet weak var lblCorner: UILabel!
    @IBOutlet weak var lblHandicap1: UILabel!
    @IBOutlet weak var lblHandicap2: UILabel!
    @IBOutlet weak var lblHandicap3: UILabel!
    @IBOutlet weak var lblOverUnder1: UILabel!
    @IBOutlet weak var lblOverUnder2: UILabel!
    @IBOutlet weak var lblOverUnder3: UILabel!
    //topView outlets ends..
    
    @IBOutlet weak var indexContainerView: UIView!
    
    @IBOutlet weak var analysisContainerView: UIView!
    //MARK: - Variables
    static var matchID:Int?
    var selectedMatch:MatchList?
    var selectedCategory = HomeCategory.index
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
       

        // Do any additional setup after loading the view.
    }
    

    func initialSetup(){
        setBackButton()
        configureTopView()
        configureContainers()
        FootballCompany.populateFootballCompanies()
    }
    
    func configureContainers(){
        switch selectedCategory{
        case .index:
            indexContainerView.isHidden = false
            analysisContainerView.isHidden = true
            
        case .analysis:
            indexContainerView.isHidden = true
            analysisContainerView.isHidden = false
            
        case .league:
            break
        case .event:
            break
        case .animation:
            break
        case .live:
            break
        }
        
    }
    
    func configureTopView(){
        lblName.text = selectedMatch?.leagueName
        lblHomeName.text = selectedMatch?.homeName
        lblAwayName.text = selectedMatch?.awayName
        lblScore.text = "\(selectedMatch?.homeScore ?? 0 ) : \(selectedMatch?.awayScore ?? 0)"
        let timeDifference = Date() - Utility.getSystemTimeZoneTime(dateString: selectedMatch?.startTime ?? "")
        let mins = ScoresTableViewCell.getMinutesFromTimeInterval(interval: timeDifference)
        lblDate.text = "\(ScoresTableViewCell.getStatus(state: selectedMatch?.state ?? 0)) \(mins)'"
        if selectedMatch?.state == 0{
            lblScore.text = "SOON"
            let date = Utility.getSystemTimeZoneTime(dateString: selectedMatch?.matchTime ?? "")
            lblDate.text = Utility.formatDate(date: date, with: .eddmmm)
        }
        let matchDate = Utility.getSystemTimeZoneTime(dateString: selectedMatch?.matchTime ?? "")
        lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)
        lblHalfScore.text = "\(selectedMatch?.homeHalfScore ?? 0) : \(selectedMatch?.awayHalfScore ?? 0)"
        lblCorner.text = "\(selectedMatch?.homeCorner ?? 0) : \(selectedMatch?.awayCorner ?? 0)"
        if selectedMatch?.odds?.handicap?.count ?? 0 > 7{
            lblHandicap1.text = String(selectedMatch?.odds?.handicap?[6] ?? 0)
        lblHandicap2.text = String(selectedMatch?.odds?.handicap?[5] ?? 0)
        lblHandicap3.text = String(selectedMatch?.odds?.handicap?[7] ?? 0)
        }
        if selectedMatch?.odds?.overUnder?.count ?? 0 > 7{
        lblOverUnder1.text = String(selectedMatch?.odds?.overUnder?[6] ?? 0)
        lblOverUnder2.text = String(selectedMatch?.odds?.overUnder?[5] ?? 0)
        lblOverUnder3.text = String(selectedMatch?.odds?.overUnder?[7] ?? 0)
        }
    }
    

}
