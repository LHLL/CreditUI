//
//  ErrorView.swift
//  WFIA
//
//  Created by Xu, Jay on 3/29/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var errorMessage: UILabel!
    
    var isEnabled:Bool = true
    
//    override func layoutSubviews() {
//        //errorMessage.layer.cornerRadius = 15
//    }
    
    func showWith(_  error:String){
        superview?.bringSubview(toFront: self)
        guard isEnabled else {return}
        errorMessage.text = "  " + error
        let group = CAAnimationGroup()
        let opa = CABasicAnimation(keyPath: "opacity")
        opa.fromValue = 0
        opa.toValue = 1
        
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: layer.position)
        var p = layer.position
        p.y += 120
        move.toValue = p
        
        group.animations = [opa,move]
        group.duration = 0.5
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        layer.add(group, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.layer.removeAllAnimations()
        }
        
    }
}
