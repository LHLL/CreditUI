//
//  TopCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/16/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class TopCell: UITableViewCell {

    @IBOutlet var steps: [UIImageView]!
    
    var current:ApprovalSteps = .First {
        didSet{
            for index in 0..<steps.count {
                steps[index].image = UIImage(named:"Stepper-\(index+1)-Off")
            }
            steps[current.rawValue].image = UIImage(named:"Stepper-\(current.rawValue+1)-On")
            var i = 0
            while i < current.rawValue {
                steps[i].image = UIImage(named:"Stepper-Complete")
                i += 1
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
