//
//  HomVewCollectionViewCell.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class HomeViewCollectionViewCell: UICollectionViewCell {
    
    lazy var cellView = { () -> UIView in
        let tp = CompanyInformationUnitView(frame: self.frame)
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(cellView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
