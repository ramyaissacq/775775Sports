//
//  LeagueViewController.swift
//  775775Sports
//
//  Created by Remya on 9/14/22.
//

import UIKit

class LeagueViewController: UIViewController {

    @IBOutlet weak var collectionViewTypes: UICollectionView!
    @IBOutlet weak var leagueStack: UIStackView!
    @IBOutlet weak var standingsStack: UIStackView!
    @IBOutlet weak var tableViewLeague: UITableView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var tableViewLeagueHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeadings: UICollectionView!
    @IBOutlet weak var tableViewStandings: UITableView!
    @IBOutlet weak var tableViewStandingsHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRule: UILabel!
    
    //MARK: - Variables
    var types = ["League / Cup Information","Match"]
    var tableViewStandingsObserver: NSKeyValueObservation?
    var tableViewLeagueObserver: NSKeyValueObservation?
    var selectedType = 0
    var leagueID:Int?
    var subLeagueID:Int?
    var groupID:Int?
    var viewModel = LeagueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()

    }
    
    func initialSetting(){
        collectionViewTypes.registerCell(identifier: "SelectionCollectionViewCell")
        tableViewLeague.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        collectionViewTypes.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        collectionViewHeadings.registerCell(identifier: "TitleCollectionViewCell")
        tableViewStandings.register(UINib(nibName: "StandingsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewStandingsObserver = tableViewStandings.observe(\.contentSize, options: .new) { (_, change) in
            guard let height = change.newValue?.height else { return }
            self.tableViewStandingsHeight.constant = height
        }
        
        tableViewLeagueObserver = tableViewLeague.observe(\.contentSize, options: .new) { (_, change) in
            guard let height = change.newValue?.height else { return }
            self.tableViewLeagueHeight.constant = height
        }
        
        viewModel.delegate = self
        viewModel.getLeagueDetails(id: leagueID ?? 0, subID: subLeagueID ?? 0, grpID: groupID ?? 0)
    }
    
    func setupDetails(){
        tableViewLeague.reloadData()
        tableViewStandings.reloadData()
        imgLogo.setImage(with: viewModel.leaguDetails?.leagueData01?.first?.leagueLogo, placeholder: Utility.getPlaceHolder())
        lblRule.text = viewModel.leaguDetails?.leagueData04?.first?.ruleEn
        
        
    }

}



extension LeagueViewController:LeagueViewModelProtocol{
    func didFinishFetch() {
        setupDetails()
       
    }
    
    
}

extension LeagueViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTypes{
            return types.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  if collectionView == collectionViewTypes{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCollectionViewCell", for: indexPath) as! SelectionCollectionViewCell
            cell.lblTitle.text = types[indexPath.row]
            cell.underLineColor = UIColor(named: "blue8")
            return cell
       // }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width / 2
        return CGSize(width: w, height: 55)
        
    }
    
    
}

extension LeagueViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewLeague{
            return viewModel.leagueInfoArray?.count ?? 0
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LeagueTableViewCell
        cell.configureCell(obj: viewModel.leagueInfoArray?[indexPath.row])
        return cell
    }
    
    
}
