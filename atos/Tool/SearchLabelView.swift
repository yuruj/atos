//
//  SearchButtonView.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class SearchLabelView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let label = UILabel()
        label.text = "搜索你想查找的企业"
        label.textColor = UIColor.gray
        label.textAlignment = .center
        label.frame = frame
        label.layer.cornerRadius = 10
        label.backgroundColor = UIColor.lightGray
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
