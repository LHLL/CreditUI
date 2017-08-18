//
//  IncomeCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/17/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class IncomeCell: UITableViewCell {

    @IBOutlet var warning: [UIImageView]!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        warning.forEach{
            $0.image = IonIcons.image(withIcon: ion_alert_circled,
                                      iconColor: AssertsManager.yellow,
                                      iconSize: 30,
                                      imageSize: CGSize(width:30,height:30))
            startBtn.layer.borderColor = UIColor.lightGray.cgColor
            startBtn.layer.borderWidth = 1
            startBtn.layer.cornerRadius = 5
            continueBtn.layer.backgroundColor = Utility.wBlue.cgColor
            continueBtn.layer.cornerRadius = 5
        }
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        gg?()
    }
    
    @IBAction func `continue`(_ sender: UIButton) {
        go?()
    }
    
}
