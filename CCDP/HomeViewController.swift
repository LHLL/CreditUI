//
//  HomeViewController.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var botBar: UIToolbar!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let bot = Utility.loadViewFromNib(with: "SignOff")
        bot?.frame = CGRect(x: 0,
                            y: view.bounds.height - 50,
                            width: view.bounds.width,
                            height: 50)
        let img1 = Utility.takeSnapshotOfView(view: bot!)
        botBar.setBackgroundImage(img1, forToolbarPosition: .top, barMetrics: .default)
        img.image = img1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
