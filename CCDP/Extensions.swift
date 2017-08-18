//
//  Extensions.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

extension UIView{
    
    func drawRoundCornor(_ left:Bool){
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: left ? [.bottomLeft , .topLeft] : [.bottomRight , .topRight],
                                      cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = rectShape
    }
}

extension UIViewController {
    
    var menu:SideMenu {
        return AssertsManager.sideMenu
    }
    
    var errorView:ErrorView{
        return AssertsManager.errorView
    }
    
    var showNext:((UIViewController)->Void){
        return { [unowned self] v in
            self.home.go(To: v)
        }
    }
    
    var home:HomeViewController {
        return navigationController!.viewControllers.first! as! HomeViewController
    }
    
    @objc func goBack(){
        guard home.childViewControllers.last! != menu else{return}
        guard home.view.subviews.last! != menu.view else{return}
        home.view.subviews.last?.removeFromSuperview()
        home.childViewControllers.last?.removeFromParentViewController()
        return
    }
    
    @objc func showSideMenu(sender:UIBarButtonItem){
        self.view.bringSubview(toFront: self.menu.view)
        if sender.tag == 0 {
            sender.isEnabled = false
            sender.tag = 1
            UIView.animate(withDuration: 0.5, animations: { 
                self.menu.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: self.view.bounds.size)
            }, completion: { (success) in
                sender.isEnabled = true
            })
        }else {
            sender.isEnabled = false
            sender.tag = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.menu.view.frame = CGRect(origin: CGPoint(x:self.view.bounds.width,y:0), size: self.view.bounds.size)
            }, completion: { (success) in
                sender.isEnabled = true
            })
        }
    }
    
    func jump(To des:UIViewController){
        let home = self.home
        guard home.childViewControllers.last! != menu else{return}
        guard home.view.subviews.last! != menu.view else{return}
        home.view.subviews.last?.removeFromSuperview()
        home.childViewControllers.last?.removeFromParentViewController()
        des.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: home.view.bounds.size)
        home.view.addSubview(des.view)
        home.addChildViewController(des)
        des.didMove(toParentViewController: home)
    }
    
    private func go(To des:UIViewController){
        if !home.childViewControllers.contains(des) {
            des.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: home.view.bounds.size)
            home.view.addSubview(des.view)
            home.addChildViewController(des)
        }else {
            home.view.bringSubview(toFront: des.view)
        }
        des.didMove(toParentViewController: home)
    }
    
    
    private func createSideMenu(){
        menu.view.frame = CGRect(origin: CGPoint(x:view.bounds.width,y:0), size: view.bounds.size)
        addChildViewController(menu)
        view.addSubview(menu.view)
        menu.didMove(toParentViewController: self)
        menu.dismissSelf = { [unowned self] in
            self.showSideMenu(sender: self.navigationItem.rightBarButtonItem!)
        }
        menu.handleIC = { [unowned self] in
            self.showSideMenu(sender: self.navigationItem.rightBarButtonItem!)
            for v in self.view.subviews {
                if v != self.menu.view && v != self.errorView{
                    v.removeFromSuperview()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PFVC") as! ProfileViewController
                if !self.childViewControllers.contains(des) {
                    self.go(To: des)
                }
                des.didMove(toParentViewController: self)
            })
        }
        menu.handleOS = { [unowned self] in
            self.showSideMenu(sender: self.navigationItem.rightBarButtonItem!)
            for v in self.view.subviews {
                if v != self.menu.view && v != self.errorView{
                    v.removeFromSuperview()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PFVC") as! ProfileViewController
                if !self.childViewControllers.contains(des) {
                    self.go(To: des)
                }
                des.didMove(toParentViewController: self)
            })
        }
    }
    
    private func configureNavigationBar(){
        let left = UIBarButtonItem(image: AssertsManager.left,
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        let right = UIBarButtonItem(image: AssertsManager.createHamburgBtn(with: .white),
                                    style: .plain,
                                    target: self,
                                    action: #selector(showSideMenu))
        navigationItem.leftBarButtonItem = left
        navigationItem.rightBarButtonItem = right
        automaticallyAdjustsScrollViewInsets = false
        let titleLogo = UIImageView(image: UIImage(named:"WF-logo"))
        navigationItem.titleView = titleLogo
    }
    
    func configureUIElements(){
        configureNavigationBar()
        createSideMenu()
        errorView.errorMessage.text = "App needs Internet access"
        errorView.frame = CGRect(x: 0,
                                 y:-120,
                                 width: view.frame.width,
                                 height: 120)
        view.addSubview(errorView)
        view.bringSubview(toFront: errorView)
    }
    
}

extension UITableViewCell{
    
    struct Shortcut{
        static var gg:(()->Void)?
        static var go:(()->Void)?
    }
    
    var gg:(()->Void)? {
        get {
            return Shortcut.gg
        }
        set {
            Shortcut.gg = newValue
        }
    }
    
    var go:(()->Void)? {
        get {
            return Shortcut.go
        }
        set {
            Shortcut.go = newValue
        }
    }
}
