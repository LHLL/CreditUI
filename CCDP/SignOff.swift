//
//  SignOff.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class SignOff: UIView {

    @IBOutlet weak var lock: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lock.image = AssertsManager.lock
    }

}
