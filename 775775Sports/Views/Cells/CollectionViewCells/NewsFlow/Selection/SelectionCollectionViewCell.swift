//
//  SelectionCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/1/22.
//

import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var underLineColor:UIColor?{
        didSet{
            underLineView.backgroundColor = underLineColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
          handleSelection()
        }
        
    }
    
    func handleSelection(){
        if isSelected{
            self.underLineView.isHidden = false
        }
        else{
            self.underLineView.isHidden = true
        }
    }

}
