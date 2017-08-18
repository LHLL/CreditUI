//
//  SideMenu.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class SideMenu: UIViewController {

    @IBOutlet weak var icBtn: UIButton!
    @IBOutlet weak var osBtn: UIButton!
    @IBOutlet weak var btnStack: UIStackView!
    @IBOutlet weak var cartView: UIImageView!
    
    var darkRed:UIColor!
    var handleIC:(()->Void)!
    var handleOS:(()->Void)!
    var dismissSelf:(()->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkRed = icBtn.backgroundColor!
        view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func handleSwipe(){
        dismissSelf()
    }
    
    @objc private func handleTap(sender:UITapGestureRecognizer){
        let point = sender.location(in: view)
        guard !cartView.frame.contains(point) else {return}
        guard !btnStack.frame.contains(point) else {return}
        dismissSelf()
    }

    @IBAction func showImmediateCredit(_ sender: UIButton) {
        osBtn.backgroundColor = darkRed
        sender.backgroundColor = AssertsManager.lighRed
        handleIC()
    }
    
    @IBAction func showOtherServices(_ sender: UIButton) {
        icBtn.backgroundColor = darkRed
        sender.backgroundColor = AssertsManager.lighRed
        handleOS()
    }
}
