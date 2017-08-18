//
//  CreditProfileCell.swift
//  CCDP
//
//  Created by Xu, Jay on 7/7/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class CreditProfileCell: UITableViewCell {

    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var buildBtn: UIButton!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var completeProfileView: CircularView!
    
    var errorHandler:(()->Void)!
    var handleOptions:(()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(colorLiteralRed: 235/255.0,
                                    green: 235/255.0,
                                    blue: 235/255.0,
                                    alpha: 1).cgColor
        layer.borderWidth = 2
        chooseBtn.layer.borderWidth = 0.3
        chooseBtn.layer.borderColor = UIColor.lightGray.cgColor
        chooseBtn.layer.cornerRadius = 5
        buildBtn.layer.cornerRadius = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(addNewProfile))
        completeProfileView.addGestureRecognizer(tap)
    }
    
    @objc private func addNewProfile(){
        completeProfileView.add()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buildProfile(_ sender: UIButton) {
        errorHandler()
    }
    
    @IBAction func chooseOptions(_ sender: UIButton) {
        handleOptions()
    }
}
