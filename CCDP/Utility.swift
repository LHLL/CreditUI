//
//  Utility.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import Foundation

struct Utility {
    
    static let mygray = UIColor(colorLiteralRed: 234/255.0,
                                green: 236/255.0,
                                blue: 239/255.0,
                                alpha: 1)
    
    static let wBlue = UIColor(colorLiteralRed: 9/255.0,
                               green: 85/255.0,
                               blue: 139/255.0,
                               alpha: 1)
    
    static func loadViewFromNib(with name:String) -> UIView? {
        if let v = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.last as? UIView {
            return v
        }else {
            return nil
        }
    }
    
    static func registerCell(from nibName:String, to owner:UITableView) {
        owner.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    static func takeSnapshotOfView(view:UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    static func drawDashLine(_ p0:CGPoint,_ P1:CGPoint){
        let  context: CGContext = UIGraphicsGetCurrentContext()!
        context.move(to: p0)
        context.addLine(to: P1)
        
        let  dashes: [ CGFloat ] = [ 3.0, 3.0]
        context.setLineDash(phase: 0.0, lengths: dashes)
        context.setLineWidth(1)
        context.setLineCap(.butt)
        UIColor.lightGray.set()
        context.strokePath()
    }
}

enum ApprovalSteps:Int {
    case First = 0
    case Second
    case Third
    case Fourth
    case Fifth
    case Confirmation
}

extension ApprovalSteps {
    
    static func goNext(_ step:ApprovalSteps)->ApprovalSteps?{
        var i = step.rawValue + 1
        let next = withUnsafeBytes(of: &i) { $0.load(as: ApprovalSteps.self) }
        if next.hashValue != i { return nil }
        return next
    }
    
    static func goPrevious(_ step:ApprovalSteps)->ApprovalSteps? {
        var i = step.rawValue - 1
        let previous = withUnsafeBytes(of: &i) { $0.load(as: ApprovalSteps.self) }
        if previous.hashValue != i { return nil }
        return previous
    }
    
    var associatedCell:UITableViewCell.Type {
        switch self {
        case .First:
            return CardDetailCell.self
        case .Second:
            return InfoCell.self
        case .Third:
            return EmploumentCell.self
        case .Fourth:
            return IncomeCell.self
        case .Fifth:
            return ExpenseCell.self
        default:
            return SignatureCell.self
        }
    }
}
