//
//  LoanTypeViewController.swift
//  CCDP
//
//  Created by Xu, Jay on 7/7/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class LoanTypeViewController: UIViewController {

    @IBOutlet weak var typeList: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardList: UITableView!
    
    fileprivate let names = ["credit card","loan","house","car","education","equity","line","dont"]
    fileprivate let titles = ["Credit Card","A Personal Loan","Mortgage","Auto Loan","Student Loan","Home Equity Loan","Personal Line of Credit","Don't Know"]
    fileprivate let limits = ["(~$5,000 limit)","(~$15,000+ limit)","","","","","","(we'll ask you a few questions)"]
    
    fileprivate let kCloseCellHeight: CGFloat = 188
    fileprivate let kOpenCellHeight: CGFloat = 580
    fileprivate let kRowsCount = 10
    fileprivate var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeList.register(UINib(nibName:"TypeCell",bundle:nil), forCellWithReuseIdentifier: "TypeCell")
        cardListSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func cardListSetup(){
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        cardList.estimatedRowHeight = kCloseCellHeight
        cardList.rowHeight = UITableViewAutomaticDimension
        Utility.registerCell(from: "CardCell", to: cardList)
    }
    
    fileprivate func showNextStep(_ index:Int){
        DispatchQueue.main.async {
            self.tableView(self.cardList, didSelectRowAt: IndexPath(row: 0, section: index))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: {
                self.cardList.visibleCells.forEach({
                    let cell = $0 as! CardCell
                    if cell.index % 2 == 0 {
                        UIView.animate(withDuration: 0.5, animations: { 
                            cell.frame = CGRect(origin: CGPoint(x:-1000,y:cell.frame.origin.y), size: cell.bounds.size)
                        }, completion: { (success) in
                            self.cardList.isHidden = true
                            self.titleLabel.isHidden = true
                        })
                    }else {
                        UIView.animate(withDuration: 0.5, animations: {
                            cell.frame = CGRect(origin: CGPoint(x:1000-cell.bounds.width,y:cell.frame.origin.y), size: cell.bounds.size)
                        }, completion: { (success) in
                            self.cardList.isHidden = true
                            self.titleLabel.isHidden = true
                        })
                    }
                })
            })
        }
    }
}

extension LoanTypeViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as! TypeCell
        cell.icon.image = UIImage(named: names[indexPath.item])
        cell.typeLabel.text = titles[indexPath.item]
        if names[indexPath.item] == "" {
            cell.height.constant = 0
        }else {
            cell.limitLabel.text = limits[indexPath.item]
        }
        return cell
    }
}

extension LoanTypeViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 60) / 2, height: 214)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item == 0 else {
            DispatchQueue.main.async {
                self.errorView.showWith("Under active development, coming soon")
            }
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! TypeCell
        cell.layer.borderColor = UIColor(colorLiteralRed: 0,
                                         green: 124/255.0,
                                         blue: 171/255.0,
                                         alpha: 1).cgColor
        var local = collectionView.visibleCells
        for index in 0..<collectionView.visibleCells.count {
            if collectionView.visibleCells[index] == cell {
                _ = local.remove(at: index)
            }
            break
        }
        local.reverse()
        scheduleDrop(local)
    }
    
    private func scheduleDrop(_ cells:[UICollectionViewCell]){
        var cellPool = cells
        guard !cellPool.isEmpty else {
            let origin = self.titleLabel.frame
            let cell = typeList.cellForItem(at: IndexPath(item: 0, section: 0)) as! TypeCell
            UIView.animate(withDuration: 1, animations: {
                cell.frame = CGRect(origin: CGPoint(x:20,
                                                    y:self.view.center.y-100),
                                    size: CGSize(width: self.view.frame.width - 40,
                                                 height: 200))
                cell.alpha = 0
                self.titleLabel.frame = CGRect.zero
            }, completion: { (success) in
                let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CSVC")
                DispatchQueue.main.async {
                    defer{
                        self.titleLabel.frame = origin
                        self.typeList.reloadData()
                    }
                    self.showNext(des)
                }
            })
            return
        }
        UIView.animate(withDuration: 1) {
            cellPool.first!.frame = CGRect(origin: CGPoint(x:cellPool.first!.frame.origin.x,
                                                           y:cellPool.first!.frame.origin.y + 1000),
                                           size: cellPool.first!.bounds.size)
        }
        _ = cellPool.remove(at: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.scheduleDrop(cellPool)
        })
    }
}

extension LoanTypeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as CardCell = cell else {
            return
        }
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.section] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion:nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.index = indexPath.section
        cell.applyHandler = { [unowned self] index in
            self.showNextStep(index)
        }
        cell.learnMoreHandler = { [unowned self] in
            DispatchQueue.main.async {
                self.errorView.showWith("Under Active Development, coming soon...")
            }
        }
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        if indexPath.section == 0 {
            cell.titleLabel.text = "WF Cash Wise Visa Card"
            cell.descriptionLabel.text = "Greate for daily use."
        }else if indexPath.section == 1{
            cell.titleLabel.text = "WF Secured Credit Card"
            cell.descriptionLabel.text = "Greate for building or rebuilding credit."
        }else {
            cell.titleLabel.text = "WF Travel Credit Card"
            cell.descriptionLabel.text = "Greate for travel."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CardCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.section] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.section] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.section] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
}
