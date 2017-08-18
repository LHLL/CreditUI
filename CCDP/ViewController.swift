//
//  ViewController.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var actionContainer: UIView!
    @IBOutlet weak var topDis: NSLayoutConstraint!
    @IBOutlet weak var doBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var rightContainer: UIView!
    private let left = Bundle.main.loadNibNamed("LeftView", owner: nil, options: nil)?.last! as! LeftView
    private let right = Bundle.main.loadNibNamed("RightView", owner: nil, options: nil)?.last! as! RightView
    private let tempLeft = Bundle.main.loadNibNamed("LeftView", owner: nil, options: nil)?.last! as! LeftView
    private let tempRight = Bundle.main.loadNibNamed("RightView", owner: nil, options: nil)?.last! as! RightView
    private let cardTitles = ["WF Cash Wize Card","WF Secured Credit Card","WF Couple Credit Card"]
    private let cardDes = ["• Has an APR of 13.45% (what's an APR?)\n• Great for small purchases and reward points\n• Convenient for paying short-term bills\n• Repay ontime to avoid fees and charges",
                           "• Has an APR of 9.9% (what's an APR?)\n• Literally the only credit card you should have\n• Convenient for Everything\n• Repay ontime to avoid fees and charges",
                           "• Has an APR of 6.6% (what's an APR?)\n• Great for couple to share reward points\n• 2x points when used by couples\n• Repay ontime to avoid fees and charges"]
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topDis.constant = 1000
        height.constant = view.bounds.height
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: { 
            self.actionContainer.frame = CGRect(origin: CGPoint.zero,
                                                size: self.actionContainer.bounds.size)
            self.actionContainer.alpha = 1
        })
    }
    
    @IBAction func showNext(_ sender: UISwipeGestureRecognizer) {
        titleLabel.text = count == 2 ? "How about this card?" : "...or this one?"
        rotateAnimation()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.actionContainer.frame = CGRect(origin: CGPoint(x: 0, y: 1000),
                                                size: self.actionContainer.bounds.size)
            self.actionContainer.alpha = 0
        })
    }
    
    @IBAction func start(_ sender: UIButton) {
        let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "APVC")
        showNext(des)
        cancel(UIButton())
    }
    
    private func setupUI(){
        rightContainer.drawRoundCornor(false)
        leftContainer.drawRoundCornor(true)
        left.frame = leftContainer.bounds
        tempLeft.frame = leftContainer.bounds
        left.titleLabel.text = cardTitles[0]
        right.titleLabel.text = cardDes[0]
        right.frame = rightContainer.bounds
        tempRight.frame = rightContainer.bounds
        leftContainer.addSubview(left)
        rightContainer.addSubview(right)
        doBtn.layer.cornerRadius = 5
        doBtn.layer.borderColor = Utility.mygray.cgColor
        doBtn.layer.borderWidth = 2
        actionContainer.alpha = 0
    }
    
    func doorAnimation(){
        let originLeft = leftContainer.frame
        let originRight = rightContainer.frame
        UIView.animate(withDuration: 0.25, animations: {
            self.leftContainer.frame = CGRect(x: 12, y: self.rightContainer.frame.origin.y, width: 0, height: 200)
            self.rightContainer.frame = CGRect(x: self.rightContainer.frame.origin.x + self.rightContainer.frame.width, y: self.rightContainer.frame.origin.y, width: 0, height: 200)
        }) { (success) in
            UIView.animate(withDuration: 0.25, animations: {
                self.leftContainer.frame = originLeft
                self.rightContainer.frame = originRight
            })
        }
    }
    
    func rotateAnimation(){
        let leftView = UIView(frame: leftContainer.frame)
        leftView.clipsToBounds = true
        tempLeft.titleLabel.text = cardTitles[count]
        leftView.addSubview(tempLeft)
        leftView.backgroundColor = leftContainer.backgroundColor
        let rightView = UIButton(frame: self.rightContainer.frame)
        rightView.clipsToBounds = true
        tempRight.titleLabel.text = cardDes[count]
        rightView.addSubview(tempRight)
        rightView.backgroundColor = rightContainer.backgroundColor
        view.addSubview(leftView)
        view.addSubview(rightView)
        let originL = leftContainer.frame
        let originR = rightContainer.frame
        leftContainer.isHidden = true
        rightContainer.isHidden = true
        count = count == 2 ? 0 : count + 1
        left.titleLabel.text = cardTitles[count]
        right.titleLabel.text = cardDes[count]
        leftContainer.frame = CGRect(origin: CGPoint(x:12,y:-300), size: leftContainer.bounds.size)
        rightContainer.frame = CGRect(origin: CGPoint(x:rightContainer.frame.origin.x,y:-300), size: leftContainer.bounds.size)
        leftContainer.isHidden = false
        rightContainer.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            leftView.frame = CGRect(x: -400, y: self.rightContainer.frame.origin.y, width: self.leftContainer.frame.width, height: 200)
            rightView.frame = CGRect(x: self.rightContainer.frame.width + 400, y: self.rightContainer.frame.origin.y, width: self.rightContainer.frame.width, height: 200)
            self.leftContainer.frame = originL
            self.rightContainer.frame = originR
        }) { (success) in
            leftView.removeFromSuperview()
            rightView.removeFromSuperview()
        }
    }
}
