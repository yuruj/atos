//
//  CompanyInformationUnitView.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class CompanyInformationUnitView: UIView {
    
    typealias completionBlock = () -> ()
    
    var clickBlock: completionBlock!
    
    lazy var companyView = { () -> UIView in
        let tp = UIView()
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(companyViewClicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    @objc func companyViewClicked() {
        clickBlock()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.addSubview(companyView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
