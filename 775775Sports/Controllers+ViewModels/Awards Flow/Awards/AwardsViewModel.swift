//
//  AwardsViewModel.swift
//  775775Sports
//
//  Created by Remya on 9/9/22.
//

import Foundation

protocol AwardsViewModeldelegate{
    func didFinishTeamStandingsFetch()
}

class AwardsViewModel{
    var delegate:AwardsViewModeldelegate?
    var teamStandings:AwardsResponse?
    
    func getTeamStandings(leagueID:Int){
        Utility.showProgress()
        AwardsAPI().getAwardsList(leagueID: leagueID, subLeagueID: 0) { response in
            self.teamStandings = response
            self.delegate?.didFinishTeamStandingsFetch()
        } failed: { msg in
            Utility.showErrorSnackView(message: msg)
        }

    }
    
    func getTeamRowByIndex(index:Int)->[String]{
        var standings = [String]()
        let obj = teamStandings?.totalStandings?[index]
        standings.append("\(obj?.rank ?? 0)")
        var team = ""
        if let teamID = obj?.teamId{
            let teamObj = teamStandings?.teamInfo?.filter{$0.teamId == teamID}.first
            team = (teamObj?.nameEn ?? "") + "," + (teamObj?.flag ?? "")
        }
        standings.append(team)
        standings.append("\(obj?.totalCount ?? 0)")
        standings.append("\(obj?.winCount ?? 0)")
        standings.append("\(obj?.drawCount ?? 0)")
        standings.append("\(obj?.loseCount ?? 0)")
        standings.append("\(obj?.getScore ?? 0)")
        standings.append("\(obj?.loseScore ?? 0)")
        standings.append("\(obj?.integral ?? 0)")
        
        return standings
    }
    
    func getResultsPercentageStringByIndex(index:Int)->String{
        let obj = teamStandings?.totalStandings?[index]
        let percentageString = "W%=\(obj?.winRate ?? "")% / L%=\(obj?.loseRate ?? "")% / AVA=\(obj?.loseAverage ?? 0) / D%=\(obj?.drawRate ?? "")% / AVF=\(obj?.winAverage ?? 0)"
        return percentageString
    }
    
    func getResultsArrayByIndex(index:Int)->[String]{
        var results = [String]()
        let obj = teamStandings?.totalStandings?[index]
        if let status = Int(obj?.recentFirstResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentSecondResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentThirdResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentFourthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentFifthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentSixthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        return results
    }
    
    func getStatusName(status:Int)->String{
        switch status{
        case 0:
            return "W"
        case 1:
            return "D"
        case 2:
            return "L"
        case 3:
            return "TBD"
        default:
            return ""
        }
    }
    
}
