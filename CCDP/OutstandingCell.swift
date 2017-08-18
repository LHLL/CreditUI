//
//  OutstandingCell.swift
//  CCDP
//
//  Created by Xu, Jay on 7/7/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class OutstandingCell: UITableViewCell {

    @IBOutlet var topCoordinates: [UIView]!
    @IBOutlet var middleCoordinates: [UIView]!
    @IBOutlet var botCoordinates: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(colorLiteralRed: 235/255.0,
                                    green: 235/255.0,
                                    blue: 235/255.0,
                                    alpha: 1).cgColor
        layer.borderWidth = 2
        topCoordinates.forEach({
            $0.layer.cornerRadius = 5
        })
        middleCoordinates.forEach({
            $0.layer.cornerRadius = 5
        })
        botCoordinates.forEach({
            $0.layer.cornerRadius = 5
        })

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        Utility.drawDashLine(topCoordinates.first!.center, topCoordinates.last!.center)
        Utility.drawDashLine(middleCoordinates.first!.center, middleCoordinates.last!.center)
        Utility.drawDashLine(botCoordinates.first!.center, botCoordinates.last!.center)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
