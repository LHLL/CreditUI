//
//  InfoCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/16/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet var tfs: [UITextField]!
    @IBOutlet var editBtns: [UIButton]!
    @IBOutlet var warning: [UIImageView]!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var indiBtn: UIButton!
    @IBOutlet weak var jointBtn: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneWall: UIView!
    @IBOutlet weak var waningLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var indiLabel: UILabel!
    @IBOutlet weak var jointLabel: UILabel!
    @IBOutlet weak var yearWall: UIView!
    @IBOutlet weak var monthWall: UIView!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    
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
                                      iconColor: phoneWall.backgroundColor,
                                      iconSize: 30,
                                      imageSize: CGSize(width:30,height:30))
        }
        indiBtn.setImage(AssertsManager.unselected, for: .normal)
        jointBtn.setImage(AssertsManager.unselected, for: .normal)
        phoneTF.layer.borderColor = phoneWall.backgroundColor?.cgColor
        phoneTF.layer.borderWidth = 1
        yearTF.layer.borderColor = phoneWall.backgroundColor?.cgColor
        yearTF.layer.borderWidth = 1
        monthTF.layer.borderColor = phoneWall.backgroundColor?.cgColor
        monthTF.layer.borderWidth = 1
        startBtn.layer.borderColor = UIColor.lightGray.cgColor
        startBtn.layer.borderWidth = 1
        startBtn.layer.cornerRadius = 5
        continueBtn.layer.backgroundColor = Utility.wBlue.cgColor
        continueBtn.layer.cornerRadius = 5
    }
    
    @IBAction func pickAccountType(_ sender: UIButton) {
        jointBtn.setImage(AssertsManager.unselected, for: .normal)
        indiBtn.setImage(AssertsManager.unselected, for: .normal)
        sender.setImage(AssertsManager.selected, for: .normal)
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        gg?()
    }
    
    @IBAction func next(_ sender: UIButton) {
        go?()
    }
    
    @IBAction func beginEditing(_ sender: UIButton) {
        let tf = tfs[editBtns.index(of: sender)!]
        tf.isUserInteractionEnabled = true
        tf.perform(#selector(becomeFirstResponder),
                   on: Thread.main,
                   with: nil,
                   waitUntilDone: true)
    }
}

extension InfoCell:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard tfs.contains(textField) else{
            textField.resignFirstResponder()
            return true
        }
        textField.isUserInteractionEnabled = false
        return true
    }
}
