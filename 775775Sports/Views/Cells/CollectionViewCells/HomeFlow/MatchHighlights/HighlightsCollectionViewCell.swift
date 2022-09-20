//
//  HighlightsCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/20/22.
//

import UIKit

class HighlightsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var scoresView: ScoresView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(obj:MatchList?){
        scoresView.configureView(obj: obj)
    }
    
    

}
