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
            
        } failed: { msg in
            Utility.showErrorSnackView(message: msg)
        }

    }
    
    func getTeamRowById(index:Int)->[String]{
        var standings = [String]()
        let obj = teamStandings?.totalStandings?[index]
        standings.append("\(obj?.rank ?? 0)")
        var team = ""
        if let teamID = obj?.teamId{
            team = teamStandings?.teamInfo?.filter{$0.teamId == teamID}.first?.nameEn ?? ""
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
    
}
