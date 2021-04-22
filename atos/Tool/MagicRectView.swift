//
//  MagicRectView.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class MagicRectView: UIView {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        return tp
    } ()
    
    lazy var numberLabel = { () -> UILabel in
        let tp = UILabel()
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.addSubview(titleLabel)
        self.addSubview(numberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

