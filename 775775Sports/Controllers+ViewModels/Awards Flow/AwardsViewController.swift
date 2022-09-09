//
//  AwardsViewController.swift
//  775775Sports
//
//  Created by Remya on 9/2/22.
//

import UIKit

class AwardsViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var lblCategory1: UILabel!
    @IBOutlet weak var lblCategory2: UILabel!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var collectionViewHeading: UICollectionView!
    @IBOutlet weak var tableViewStandings: UITableView!
    @IBOutlet weak var tableViewStandingsHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    var tableViewStandingsObserver: NSKeyValueObservation?
    var topTitles = ["Team Standings","Player Standings"]
    var headings1 = ["Ranking","Team Name","MP","W","D","L","GF","GA","PTs","More"]
    var headings2 = ["Rank","Team Name","Player Name","Goals","Home","Away","More"]
    var firstHeaderSizes = [CGFloat]()
    var secondHeaderSizes = [CGFloat]()
    var headers = [String]()
    var headerSizes = [CGFloat]()
    var selectedTopTitleIndex = 0
    static var selectedPlayerMoreIndices = [Int]()
    static var selectedTeamMoreIndices = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    func initialSettings(){
        headers = headings1
        collectionViewTop.registerCell(identifier: "SelectionCollectionViewCell")
        collectionViewHeading.registerCell(identifier: "TitleCollectionViewCell")
        tableViewStandings.register(UINib(nibName: "StandingsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableViewStandingsObserver = tableViewStandings.observe(\.contentSize, options: .new) { (_, change) in
            guard let height = change.newValue?.height else { return }
            self.tableViewStandingsHeight.constant = height
        }
        collectionViewTop.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        
        //Calculating cell widths for headings1
        firstHeaderSizes = [40,85,15,15,15,15,15,15,20,25]
        var itemSpacing:CGFloat = CGFloat((headings1.count - 1) * 5)
        var total_widths:CGFloat = firstHeaderSizes.reduce(0, +)
        var totalSpace:CGFloat = total_widths + itemSpacing
        var balance = (UIScreen.main.bounds.width - totalSpace)/CGFloat(headings1.count)
        firstHeaderSizes = firstHeaderSizes.map{$0+balance}
        headerSizes = firstHeaderSizes
        
        //Calculating cell widths for headings2
        secondHeaderSizes = [25,85,85,25,25,25,25]
       itemSpacing = CGFloat((headings2.count - 1) * 5)
        total_widths = secondHeaderSizes.reduce(0, +)
        totalSpace = total_widths + itemSpacing
        balance = (UIScreen.main.bounds.width - totalSpace)/CGFloat(headings2.count)
        secondHeaderSizes = secondHeaderSizes.map{$0+balance}
        
        
        
    }
    
    func setupViews(){
        if selectedTopTitleIndex == 0{
            headers = headings1
            headerSizes = firstHeaderSizes
        }
        else{
            headers = headings2
            headerSizes = secondHeaderSizes
        }
        collectionViewHeading.reloadData()
        tableViewStandings.reloadData()
        
    }

}

extension AwardsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTop{
            return topTitles.count
        }
        else{
            return headers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewTop{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCollectionViewCell", for: indexPath) as! SelectionCollectionViewCell
            cell.lblTitle.text = topTitles[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
            cell.titleType = .RedHeader
            cell.lblTitle.text = headers[indexPath.row]
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewTop{
            selectedTopTitleIndex = indexPath.row
            setupViews()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewTop{
            let w = UIScreen.main.bounds.width / 2
            return CGSize(width: w, height: 55)
        }
        else{
            return CGSize(width: headerSizes[indexPath.row], height: 55)
        }
    }
    
    
}

extension AwardsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StandingsTableViewCell
        cell.cellIndex = indexPath.row
        if selectedTopTitleIndex == 0{
            cell.isTeamStandigs = true
        }
        else{
            cell.isTeamStandigs = false
        }
        cell.callReloadCell = {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        cell.headerSizes = headerSizes
        cell.collectionViewStandings.reloadData()
        return cell
    }
    
    
}
