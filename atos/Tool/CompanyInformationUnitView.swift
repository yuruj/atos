//
//  CompanyInformationUnitView.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class CompanyInformationUnitView: UIView {
    
//    typealias completionBlock = () -> ()
//
//    var clickBlock: completionBlock!
//
//    lazy var companyView = { () -> UIView in
////        let tapGes = UITapGestureRecognizer()
////        tapGes.addTarget(self, action: #selector(companyViewClicked))
////        tp.addGestureRecognizer(tapGes)
//        let tp = UIView()
//        tp.backgroundColor = UIColor.white
//        tp.layer.cornerRadius = 5
//        tp.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
//        return tp
//    } ()
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "重庆名都科技有限公司"
        tp.frame = CGRect(x: 10, y: 10, width: self.bounds.size.width, height: self.bounds.size.height/2)
        return tp
    } ()
    
//    @objc func companyViewClicked() {
//        clickBlock()
//    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
