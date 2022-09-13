//
//  HomeAPI.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import Foundation

class HomeAPI: WebService {
   
    func getScores(page:Int,completion:@escaping (ScoresResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.scores.rawValue + "/\(Utility.getCurrentLang())/\(page)"
        get(url: url, params: [:], completion: { json in
            let response = ScoresResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    func getScoresByIndex(completion:@escaping (ScoresByIndexResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.scores_index.rawValue
        get(url: url, params: [:], completion: { json in
            let response = ScoresByIndexResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    func getScoresByAnalysis(id:Int,completion:@escaping (ScoreAnalysisResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.scores_analysis.rawValue + "/\(id)"
        get(url: url, params: [:], completion: { json in
            let response = ScoreAnalysisResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    func getEvents(completion:@escaping (EventResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.scores_events.rawValue
        get(url: url, params: [:], completion: { json in
            let response = EventResponse(json!)
            completion(response)
        }, failed: failed)
    }
}
