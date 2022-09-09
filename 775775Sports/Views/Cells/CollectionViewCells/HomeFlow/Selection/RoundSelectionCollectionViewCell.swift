//
//  RoundSelectionCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import UIKit

class RoundSelectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var lblTite:UILabel!
    
    override var isSelected: Bool{
        didSet{
            handleSelection()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func handleSelection(){
        if isSelected{
            backView.backgroundColor = Colors.blue3Color()
            lblTite.textColor = .white
        }
        else{
            backView.backgroundColor = Colors.blue2Color()
            lblTite.textColor = Colors.gray1Color()
        }
    }

}
