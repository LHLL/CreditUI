//
//  SignatureCell.swift
//  CCDP
//
//  Created by Xu, Jay on 8/17/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class SignatureCell: UITableViewCell {

    @IBOutlet weak var tcLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    
    private lazy var signatureView:SignatureView = { [unowned self] in
        let s = Bundle.main.loadNibNamed("SignatureView",
                                         owner: nil,
                                         options: nil)?.last as! SignatureView
        s.frame = self.tcLabel.frame
        s.layer.borderWidth = 1
        s.layer.borderColor = Utility.mygray.cgColor
        return s
        }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 5
        signBtn.layer.backgroundColor = Utility.wBlue.cgColor
        signBtn.layer.cornerRadius = 5
        tcLabel.layer.borderColor = Utility.mygray.cgColor
        tcLabel.layer.borderWidth = 1
    }
    
    @IBAction func cancelSign(_ sender: UIButton) {
        guard sender.currentTitle == "Cancel" else{
            signatureView.clear()
            return
        }
        gg?()
    }
    
    @IBAction func sign(_ sender: UIButton) {
        if sender.currentTitle == "Sign" {
            tcLabel.isHidden = true
            sender.setTitle("Confirm", for: .normal)
            addSubview(signatureView)
            cancelBtn.setTitle("Clear", for: .normal)
        }else {
            go?()
        }
    }
}
