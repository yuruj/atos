//
//  HomVewCollectionViewCell.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class HomeViewCollectionViewCell: UICollectionViewCell {
    
    var view: CompanyInformationUnitView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = CompanyInformationUnitView(frame: self.contentView.frame)
        self.contentView.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
