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
    
    //MARK: - Variables
    var viewModel = HomeVieModel()
    var page = 1
    var refreshControl:UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

        // Do any additional setup after loading the view.
    }
    
    func initialSettings(){
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
    
}

extension HomeViewController:HomeViewModelDelegate{
    func diFinisfFetchMatches() {
        page += 1
        tableView.reloadData()
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeCategoryViewController") as! HomeCategoryViewController
            HomeCategoryViewController.matchID = self.viewModel.matches?[indexPath.row].matchId
            vc.selectedMatch =  self.viewModel.matches?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.configureCell(obj: viewModel.matches?[indexPath.row])
        return cell
        
    }
    

    
    
}
