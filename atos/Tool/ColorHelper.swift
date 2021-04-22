//
//  ColorHelper.swift
//  atos
//
//  Created by 余润杰 on 2021/4/19.
//

import UIKit

extension UIColor {
    
    public convenience init(red:UInt8, green:UInt8, blue:UInt8 ) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
    
}
