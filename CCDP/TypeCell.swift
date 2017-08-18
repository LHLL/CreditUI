//
//  TypeCell.swift
//  CCDP
//
//  Created by Xu, Jay on 7/7/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(colorLiteralRed: 235/255.0,
                                    green: 235/255.0,
                                    blue: 235/255.0,
                                    alpha: 1).cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
    }
}
