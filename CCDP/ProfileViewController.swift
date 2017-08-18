//
//  ProfileViewController.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func tableviewSetup(){
        automaticallyAdjustsScrollViewInsets = false
        profileList.estimatedRowHeight = 66
        profileList.rowHeight = UITableViewAutomaticDimension
        Utility.registerCell(from: "CreditProfileCell", to: profileList)
        Utility.registerCell(from: "OutstandingCell", to: profileList)
    }
}

extension ProfileViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CreditProfileCell", for: indexPath)
            (cell as! CreditProfileCell).errorHandler = { [unowned self] in
                DispatchQueue.main.async {
                    self.errorView.showWith("Under active development, coming soon...")
                }
            }
            (cell as! CreditProfileCell).handleOptions = { [unowned self] in
                let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LTVC") as! LoanTypeViewController
                self.showNext(next)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                (cell as! CreditProfileCell).completeProfileView.start()
            })
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "OutstandingCell", for: indexPath)
        }
        return cell
    }
}

extension ProfileViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        return v
    }
}
