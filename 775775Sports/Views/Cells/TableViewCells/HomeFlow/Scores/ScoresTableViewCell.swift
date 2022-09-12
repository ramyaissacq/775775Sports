//
//  ScoresTableViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/5/22.
//

import UIKit


class ScoresTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
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
    
    //MARK: - Variables
    var callIndexSelection:(()->Void)?
    var callAnalysisSelection:(()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapIndex))
        viewIndex.addGestureRecognizer(tap)
        
        let tapAnls = UITapGestureRecognizer(target: self, action: #selector(tapAnalysis))
        viewAnalysis.addGestureRecognizer(tapAnls)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func tapIndex(){
        callIndexSelection?()
        
    }
    
    
    @objc func tapAnalysis(){
        callAnalysisSelection?()
        
    }
    
    func configureCell(obj:MatchList?){
        lblName.text = obj?.leagueName
        lblHomeName.text = obj?.homeName
        lblAwayName.text = obj?.awayName
        lblScore.text = "\(obj?.homeScore ?? 0 ) : \(obj?.awayScore ?? 0)"
        let timeDifference = Date() - Utility.getSystemTimeZoneTime(dateString: obj?.startTime ?? "")
        let mins = ScoresTableViewCell.getMinutesFromTimeInterval(interval: timeDifference)
        lblDate.text = "\(ScoresTableViewCell.getStatus(state: obj?.state ?? 0)) \(mins)'"
        if obj?.state == 0{
            lblScore.text = "SOON"
            let date = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
            lblDate.text = Utility.formatDate(date: date, with: .eddmmm)
        }
        let matchDate = Utility.getSystemTimeZoneTime(dateString: obj?.matchTime ?? "")
        lblTime.text = Utility.formatDate(date: matchDate, with: .hhmm2)
        lblHalfScore.text = "\(obj?.homeHalfScore ?? 0) : \(obj?.awayHalfScore ?? 0)"
        lblCorner.text = "\(obj?.homeCorner ?? 0) : \(obj?.awayCorner ?? 0)"
        if obj?.odds?.handicap?.count ?? 0 > 7{
        lblHandicap1.text = String(obj?.odds?.handicap?[6] ?? 0)
        lblHandicap2.text = String(obj?.odds?.handicap?[5] ?? 0)
        lblHandicap3.text = String(obj?.odds?.handicap?[7] ?? 0)
        }
        if obj?.odds?.overUnder?.count ?? 0 > 7{
        lblOverUnder1.text = String(obj?.odds?.overUnder?[6] ?? 0)
        lblOverUnder2.text = String(obj?.odds?.overUnder?[5] ?? 0)
        lblOverUnder3.text = String(obj?.odds?.overUnder?[7] ?? 0)
        }
    }
    
    class func getStatus(state:Int)->String{
        var value = ""
        switch state{
        case 0:
            value = "SOON"
        case 1:
            value = "FH"
        case 2:
            value = "HT"
        case 3:
            value = "SH"
        case 4:
            value = "OT"
        case 5:
            value = "PT"
        case -1:
            value = "FT"
        case -10:
            value = "C"
        case -11:
            value = "TBD"
        case -12:
            value = "CIH"
        case -13:
            value = "INT"
        case -14:
            value = "DEL"
            
        default:
            break
        }
        return value
    }
    
   
    
    class func getMinutesFromTimeInterval(interval: TimeInterval)->Int{
          let time = NSInteger(interval)
          //let seconds = time % 60
          let minutes = (time / 60) % 60
          //let hours = (time / 3600)
          return minutes
        }
    
    
    
}
