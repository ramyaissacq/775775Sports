//
//  GeneralRowTableViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import UIKit

class GeneralRowTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionViewRow: UICollectionView!
    
    //MARK: - Variables
    var values:[String]?{
        didSet{
            collectionViewRow.reloadData()
        }
    }
    var headerSizes = [CGFloat]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewRow.delegate = self
        collectionViewRow.dataSource = self
        collectionViewRow.registerCell(identifier: "TitleCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension GeneralRowTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        cell.titleType = .Normal
        if indexPath.row == 0{
            if let id = Int(values?.first ?? ""){
            cell.lblTitle.text = FootballCompany.getCompanyName(id: id)
            }
        }
        else{
        cell.lblTitle.text = values?[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: headerSizes[indexPath.row], height: 55)
    }
    
}
