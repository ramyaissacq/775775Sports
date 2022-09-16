//
//  HomeViewController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import UIKit

class HomeViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var noDataView: UIView!
    //MARK: - Variables
    var viewModel = HomeVieModel()
    var page = 1
    var refreshControl:UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    func initialSettings(){
        setupNavButtons()
        tableView.register(UINib(nibName: "ScoresTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clear
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        viewModel.delegate = self
        viewModel.getMatchesList(page: page)
    }
    
    @objc func refresh(){
        page = 1
        viewModel.getMatchesList(page: page)
        refreshControl?.endRefreshing()
    }
    
    func setupNavButtons(){
        let leftBtn = getButton(image: UIImage(named: "menu")!)
        leftBtn.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = getButton(image: UIImage(named: "search")!)
        rightBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    @objc func menuTapped(){
        
    }
   
    @objc func searchTapped(){
        
    }
    
    
}

extension HomeViewController:HomeViewModelDelegate{
    func diFinisfFetchMatches() {
        page += 1
        tableView.reloadData()
        if viewModel.matches?.count ?? 0 > 0{
            noDataView.isHidden = true
        }
        else{
            noDataView.isHidden = false
        }
    }
  
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getModelCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.getModelCount()-1{
            if page <= (viewModel.pageData?.lastPage ?? 0){
            viewModel.getMatchesList(page: page)
            }
        }
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
        
        cell.configureCell(obj: viewModel.matches?[indexPath.row])
        return cell
        
    }
    
    func goToCategory(index:Int,category:HomeCategory){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCategoryViewController") as! HomeCategoryViewController
        HomeCategoryViewController.matchID = self.viewModel.matches?[index].matchId
        vc.selectedMatch =  self.viewModel.matches?[index]
        vc.selectedCategory = category
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    
}
