//
//  CardCell.swift
//  CCDP
//
//  Created by Xu, Jay on 7/10/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class CardCell: FoldingCell {

    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var learnMoreBtn: UIButton!
    
    var index = -1
    var applyHandler:((_ index:Int)->Void)!
    var learnMoreHandler:(()->Void)!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        applyBtn.layer.cornerRadius = 5
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2, 0.2, 0.2]
        return durations[itemIndex]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func apply(_ sender: UIButton) {
        applyHandler(index)
    }
    
    @IBAction func learnMore(_ sender: UIButton) {
        learnMoreHandler()
    }
    
}
