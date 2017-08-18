//
//  EmploumentCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/17/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class EmploumentCell: UITableViewCell {

    @IBOutlet var tfs: [UITextField]!
    @IBOutlet var editBtns: [UIButton]!
    @IBOutlet var warning: [UIImageView]!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtns.forEach{
            $0.setImage(AssertsManager.pen, for: .normal)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.cornerRadius = 15
        }
        tfs.forEach{
            $0.delegate = self
        }
        warning.forEach{
            $0.image = IonIcons.image(withIcon: ion_alert_circled,
                                      iconColor: AssertsManager.yellow,
                                      iconSize: 30,
                                      imageSize: CGSize(width:30,height:30))
        }
        startBtn.layer.borderColor = UIColor.lightGray.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = 5
        continueBtn.layer.backgroundColor = Utility.wBlue.cgColor
        continueBtn.layer.cornerRadius = 5
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        gg?()
    }
    
    @IBAction func next(_ sender: UIButton) {
        go?()
    }
}

extension EmploumentCell:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard tfs.contains(textField) else{
            textField.resignFirstResponder()
            return true
        }
        textField.isUserInteractionEnabled = false
        return true
    }
}
