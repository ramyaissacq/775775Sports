//
//  SearchViewController.swift
//  775775Sports
//
//  Created by Remya on 9/17/22.
//

import UIKit

class SearchViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: - Variables
    var matches:[MatchList]?
    var originals:[MatchList]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    func initialSettings(){
        setTitle()
        setBackButton()
        tableView.register(UINib(nibName: "ScoresTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
}

//MARK: - Searchbar Delegates
extension SearchViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trim() != ""{
            doSearch(searchText: searchText)
            
        }
        else{
            self.matches = self.originals
            tableView.reloadData()
        }
        
    }
    
    func doSearch(searchText:String){
        matches?.removeAll()
        matches = originals?.filter{($0.leagueName?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.homeName?.lowercased().contains(searchText.lowercased()) ?? false) || ($0.awayName?.lowercased().contains(searchText.lowercased()) ?? false)}
        tableView.reloadData()
        
    }
    
    
}

//MARK: - TableView Delegates
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ScoresTableViewCell
        cell.callIndexSelection = {
            self.goToCategory(index: indexPath.row, category: .index)
        }
        
        cell.callAnalysisSelection = {
            self.goToCategory(index: indexPath.row, category: .analysis)
        }
        
        cell.callEventSelection = {
            self.goToCategory(index: indexPath.row, category: .event)
            
        }
        cell.callBriefingSelection = {
            self.goToCategory(index: indexPath.row, category: .breifing)
            
        }
        cell.callLeagueSelection = {
            self.goToCategory(index: indexPath.row, category: .league)
            
        }
        
        cell.configureCell(obj: matches?[indexPath.row])
        return cell
        
    }
    
    func goToCategory(index:Int,category:HomeCategory){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCategoryViewController") as! HomeCategoryViewController
        HomeCategoryViewController.matchID = self.matches?[index].matchId
        vc.selectedMatch =  self.matches?[index]
        vc.selectedCategory = category
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
    
}
