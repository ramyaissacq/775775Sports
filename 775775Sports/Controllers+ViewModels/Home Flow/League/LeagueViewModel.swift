//
//  LeagueViewModel.swift
//  775775Sports
//
//  Created by Remya on 9/14/22.
//

import Foundation

protocol LeagueViewModelProtocol{
    func didFinishFetch()
}
class LeagueViewModel{
    var delegate:LeagueViewModelProtocol?
    var leaguDetails:LeagueResponse?
    var leagueInfoArray:[League]?
    func getLeagueDetails(id:Int,subID:Int,grpID:Int){
        Utility.showProgress()
        HomeAPI().getLeagueDetails(id: id, subID: subID, grpID: grpID) { response in
            self.leaguDetails = response
            self.populateData()
            self.delegate?.didFinishFetch()
        } failed: { _ in
            
        }

    }
    
    func populateData(){
        var tmpArr = [League]()
        let keys = ["Full Name :","Abbreviation :","Type :","Current Sub-League :","Total Rounds :","Current Round :","Current Season :","Country :"]
        var values = [String]()
        values.append(leaguDetails?.leagueData01?.first?.nameEn ?? "")
        values.append(leaguDetails?.leagueData01?.first?.nameEnShort ?? "")
        values.append("League")
        values.append(leaguDetails?.leagueData02?.first?.subNameEn ?? "")
        values.append(leaguDetails?.leagueData02?.first?.totalRound ?? "")
        values.append(leaguDetails?.leagueData02?.first?.currentRound ?? "")
        values.append(leaguDetails?.leagueData02?.first?.currentSeason ?? "")
        values.append(leaguDetails?.leagueData01?.first?.countryEn ?? "")
        
        for i in 0...values.count-1{
            let obj = League(key: keys[i], value: values[i])
            tmpArr.append(obj)
        }
        leagueInfoArray = tmpArr
        
    }
    
    
}
