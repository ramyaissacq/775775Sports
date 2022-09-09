//
//  HomeViewModel.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import Foundation
protocol HomeViewModelDelegate{
    
    func diFinisfFetchMatches()
    
}

class HomeVieModel{
    var delegate:HomeViewModelDelegate?
    var matches:[MatchList]?
    var pageData:Meta?
    
    func getMatchesList(page:Int){
        Utility.showProgress()
        HomeAPI().getScores(page: page) { response in
            if page > 1 {
                var tempMatches = self.matches ?? []
                tempMatches.append(contentsOf: response.matchList ?? [])
                self.matches = tempMatches
            }
            else{
            self.matches = response.matchList
            }
            self.pageData = response.meta
            self.delegate?.diFinisfFetchMatches()
            print("count::\(self.matches?.count ?? 0)")
        } failed: { msg in
            Utility.showErrorSnackView(message: msg)
        }

    }
    
    func getModelCount()->Int{
        return matches?.count ?? 0
    }
    
}
