//
//  ApplicationViewController.swift
//  CCDP
//
//  Created by Xu, Jay on 8/16/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController {

    @IBOutlet weak var processList: UITableView!
    fileprivate var step:ApprovalSteps = .First
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func startOver(){
        step = .First
        DispatchQueue.main.async {
            self.processList.reloadData()
        }
    }
    
    fileprivate func forward(){
        guard let s = ApprovalSteps.goNext(step) else{
            let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DoneVC")
            jump(To:des)
            return
        }
        step = s
        DispatchQueue.main.async {
            self.processList.reloadData()
            self.processList.scrollToRow(at: IndexPath(row:0,section:0),
                                         at: .top,
                                         animated: false)
        }
    }
    
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        processList.register(UINib(nibName: "TopCell", bundle: nil),
                             forCellReuseIdentifier: "TopCell")
        processList.register(UINib(nibName: "CardDetailCell", bundle: nil),
                             forCellReuseIdentifier: "CardDetailCell")
        processList.register(UINib(nibName: "InfoCell", bundle: nil),
                             forCellReuseIdentifier: "InfoCell")
        processList.register(UINib(nibName: "EmploumentCell", bundle: nil),
                             forCellReuseIdentifier: "EmploumentCell")
        processList.register(UINib(nibName: "IncomeCell", bundle: nil),
                             forCellReuseIdentifier: "IncomeCell")
        processList.register(UINib(nibName: "ExpenseCell", bundle: nil),
                             forCellReuseIdentifier: "ExpenseCell")
        processList.register(UINib(nibName: "SignatureCell", bundle: nil),
                             forCellReuseIdentifier: "SignatureCell")
        processList.estimatedRowHeight = 100
        processList.rowHeight = UITableViewAutomaticDimension
    }
}

extension ApplicationViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath)
            (cell as! TopCell).current = step
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: step.associatedCell), for: indexPath)
            cell.gg = {[unowned self] in
                self.startOver()
            }
            cell.go = { [unowned self] in
                self.forward()
            }
        }
        return cell
    }
}
