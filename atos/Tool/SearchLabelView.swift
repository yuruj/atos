//
//  SearchButtonView.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class SearchLabelView: UIView {
    
    lazy var label = { () -> UILabel in
        let label = UILabel()
        label.text = "搜索你想查找的企业"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect(x: 15, y: 10, width: frame.size.width - 30, height: frame.size.height - 20)
        label.layer.cornerRadius = (frame.size.height - 20) / 2
        label.layer.masksToBounds = true
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
