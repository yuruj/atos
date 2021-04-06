//
//  CustomerOverviewViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

enum CustomerType: String {
    case allCustomer = "所有客户"
    case importantCustomer = "重点客户"
    case newCustomer = "新客户"
    case energyEfficiencyCustomer = "能效客户"
}

class CustomerOverviewViewController: UIViewController {
    
    var currentCustomerType: CustomerType = .allCustomer
    
    lazy var currentCustomerBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle(currentCustomerType.rawValue, for: .normal)
        tp.addTarget(self, action: #selector(currentCustomerBtnClicked), for: .touchUpInside)
//        tp.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func currentCustomerBtnClicked() {
        NSLog("----选择客户类型----")
    }
}
