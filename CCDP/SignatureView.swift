//
//  SignatureView.swift
//  ADF
//
//  Created by Xu, Jay on 6/8/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class SignatureView: UIView {

    @IBOutlet weak var signatureImageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func clear(){
        signatureImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            drawLine(From: lastPoint, to: touch.location(in: self))
            lastPoint = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(From: lastPoint, to: lastPoint)
        }
        
        UIGraphicsBeginImageContext(frame.size)
        signatureImageView.image?.draw(in: CGRect(x: 0,
                                                  y: 0,
                                                  width: frame.size.width,
                                                  height: frame.size.height),
                                       blendMode: .normal,
                                       alpha: 1.0)
        signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func drawLine(From sp:CGPoint,to ep:CGPoint) {
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        signatureImageView.image?.draw(in: CGRect(x: 0, y: 0, width:frame.size.width, height: frame.size.height))
        
        context?.move(to: sp)
        context?.addLine(to: ep)
        
        context?.setLineWidth(brushWidth)
        context?.setLineCap(.round)
        context?.setBlendMode(.normal)
        context!.strokePath()
        
        signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        signatureImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }

}
