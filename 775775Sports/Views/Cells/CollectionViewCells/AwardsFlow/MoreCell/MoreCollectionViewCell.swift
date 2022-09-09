//
//  MoreCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/3/22.
//

import UIKit

class MoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgArrow:UIImageView!
    
    var cellIndex = 0
    var isTeamStandings = true

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupViews(){
        if isTeamStandings{
            if AwardsViewController.selectedTeamMoreIndices.contains(cellIndex){
                imgArrow.transform = CGAffineTransform(rotationAngle: 180)
                
            }
            else{
                imgArrow.transform = .identity
            }
        }
    }

}
