//
//  StandingsTableViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/3/22.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionViewStandings: UICollectionView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var collectionViewLastResults: UICollectionView!
    @IBOutlet weak var collectionViewPoints: UICollectionView!
    //MARK: - Variables
    
    var cellIndex = 0
    var isTeamStandigs:Bool?{
        didSet{
            setupView()
        }
    }
    
    var callReloadCell:(() -> Void)?
    
    var teamStandings = ["1","Man City","20","20","20","20","20","20","20"]
    var playerStandings = ["1","Man City","Erling Haland","20","20","20"]
    var headerSizes = [CGFloat]()
    
    var standings = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewLastResults.delegate = self
        collectionViewLastResults.dataSource = self
        collectionViewPoints.delegate = self
        collectionViewPoints.dataSource = self
        collectionViewStandings.delegate = self
        collectionViewStandings.dataSource = self
        collectionViewStandings.registerCell(identifier: "RankCollectionViewCell")
        collectionViewStandings.registerCell(identifier: "TeamCollectionViewCell")
        collectionViewStandings.registerCell(identifier: "MoreCollectionViewCell")
        collectionViewStandings.registerCell(identifier: "TitleCollectionViewCell")
        collectionViewPoints.registerCell(identifier: "PointsCollectionViewCell")
        collectionViewLastResults.registerCell(identifier: "ResultCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(){
        resultsView.isHidden = true
        pointsView.isHidden = true
        if isTeamStandigs ?? false{
            standings = teamStandings
            collectionViewStandings.reloadData()
            
        }
        else{
            standings = playerStandings
            collectionViewStandings.reloadData()
            
        }
        configureMoreViews()
        
        
    }
    
    func configureMoreViews(){
        if isTeamStandigs ?? false{
            if AwardsViewController.selectedTeamMoreIndices.contains(cellIndex){
                resultsView.isHidden = false
            }
            else{
                resultsView.isHidden = true
            }
            
        }
        else{
            if AwardsViewController.selectedPlayerMoreIndices.contains(cellIndex){
                pointsView.isHidden = false
            }
            else{
                pointsView.isHidden = true
            }
            
        }
        
    }
    
    
    
    
    
    
}

//MARK: - CollectionView Delegates
extension StandingsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewLastResults{
            return 6
        }
        else if collectionView == collectionViewStandings{
            return standings.count + 1
        }
        else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewPoints{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointsCollectionViewCell", for: indexPath) as! PointsCollectionViewCell
            return cell
            
        }
        else if collectionView == collectionViewLastResults{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
            return cell
            
        }
       else if collectionView == collectionViewStandings && isTeamStandigs ?? false{
            switch indexPath.row{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankCollectionViewCell", for: indexPath) as! RankCollectionViewCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
                return cell
            case standings.count:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
                cell.cellIndex = cellIndex
                cell.isTeamStandings = true
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
                cell.titleType = .Normal
                cell.lblTitle.text = teamStandings[indexPath.row]
                return cell
           
        }
       }
            else{
                if indexPath.row == playerStandings.count{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
                    cell.isTeamStandings = false
                    cell.cellIndex = cellIndex
                    return cell
                    
                }
                
                else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
                    cell.titleType = .Normal
                    cell.lblTitle.text = playerStandings[indexPath.row]
                    return cell
                    
                }
                
            }
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewStandings && isTeamStandigs ?? false{
            if indexPath.row == teamStandings.count{
                
                if AwardsViewController.selectedTeamMoreIndices.contains(cellIndex){
                    AwardsViewController.selectedTeamMoreIndices.remove(at: AwardsViewController.selectedTeamMoreIndices.firstIndex(of: cellIndex)!)
                    resultsView.isHidden = true
                }
                else{
                    AwardsViewController.selectedTeamMoreIndices.append(cellIndex)
                }
                callReloadCell?()
            }
        }
        
        else if collectionView == collectionViewStandings && indexPath.row == playerStandings.count{
            if AwardsViewController.selectedPlayerMoreIndices.contains(cellIndex){
                AwardsViewController.selectedPlayerMoreIndices.remove(at: AwardsViewController.selectedPlayerMoreIndices.firstIndex(of: cellIndex)!)
                pointsView.isHidden = true
            }
            else{
                AwardsViewController.selectedPlayerMoreIndices.append(cellIndex)
            }
            callReloadCell?()
            
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewLastResults{
            return CGSize(width: 20, height: 20)
        }
        else if collectionView == collectionViewPoints{
            return CGSize(width: 80, height: 30)
            
        }
        return CGSize(width: headerSizes[indexPath.row], height: 55)
    }
    
    
}
