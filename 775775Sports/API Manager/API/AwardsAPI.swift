//
//  AwardsAPI.swift
//  775775Sports
//
//  Created by Remya on 9/9/22.
//

import Foundation

class AwardsAPI:WebService{
    
    func getAwardsList(leagueID:Int,subLeagueID:Int,completion:@escaping (AwardsResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.awards.rawValue + "/\(leagueID)/sub/\(subLeagueID)"
        get(url: url, params: [:], completion: { json in
            let response = AwardsResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    
}
