//
//  CardDetailCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/16/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class CardDetailCell: UITableViewCell {

    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var apr: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        continueBtn.backgroundColor = Utility.wBlue
        continueBtn.layer.cornerRadius = 5
        startBtn.layer.borderColor = Utility.mygray.cgColor
        startBtn.layer.borderWidth = 0.5
        startBtn.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        gg?()
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        go?()
    }
}
