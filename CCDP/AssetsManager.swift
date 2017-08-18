//
//  AssetsManager.swift
//  CCDP
//
//  Created by Xu, Jay on 7/6/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import Foundation
import UIKit

struct AssertsManager {
    
    static let yellow = UIColor(colorLiteralRed: 220.0/255.0,
                                green: 128.0/255.0,
                                blue: 32.0/255.0,
                                alpha: 1)
    
    static let left = IonIcons.image(withIcon: ion_ios_arrow_thin_left,
                                     iconColor: .white,
                                     iconSize: 35,
                                     imageSize: CGSize(width:35,height:35))
    
    static let lock = IonIcons.image(withIcon: ion_ios_locked_outline,
                                     iconColor: .white,
                                     iconSize: 35,
                                     imageSize: CGSize(width:35,height:35))
    
    static func createHamburgBtn(with color:UIColor) -> UIImage{
        return IonIcons.image(withIcon: ion_navicon,
                              iconColor: color,
                              iconSize: 35,
                              imageSize: CGSize(width:35,height:35))
    }
    
    static let lighRed = UIColor(colorLiteralRed: 232.0/255.0,
                                 green: 26.0/255.0,
                                 blue: 41.0/255.0,
                                 alpha: 1)
    
    static let pen = IonIcons.image(withIcon: ion_edit,
                                    iconColor: .lightGray,
                                    iconSize: 20,
                                    imageSize: CGSize(width:20,height:20))
    
    static let selected = IonIcons.image(withIcon: ion_ios_circle_filled,
                                         iconColor: yellow,
                                         iconSize: 20,
                                         imageSize: CGSize(width: 20, height: 20))
    
    static let unselected = IonIcons.image(withIcon: ion_ios_circle_outline,
                                           iconColor: yellow,
                                           iconSize: 20,
                                           imageSize: CGSize(width: 20, height: 20))
    
    static let sideMenu:SideMenu = SideMenu(nibName: "SideMenu", bundle: nil)
    
    static let errorView = Bundle.main.loadNibNamed("ErrorView", owner: nil, options: nil)!.last! as! ErrorView
}
