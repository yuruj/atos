//
//  CustomerOverviewViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

enum CustomerType: String {
    case allCustomer              = "所有客户"
    case importantCustomer        = "重点客户"
    case newCustomer              = "新客户"
    case energyEfficiencyCustomer = "能效客户"
}

class CustomerOverviewViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    var currentCustomerType: CustomerType = .allCustomer
    
    lazy var currentCustomerBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle(currentCustomerType.rawValue, for: .normal)
        tp.addTarget(self, action: #selector(currentCustomerBtnClicked), for: .touchUpInside)
//        tp.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        return tp
    } ()
    
    lazy var collectionView = { () -> UICollectionView in
        let tp = UICollectionView()
        return tp
    } ()
    
    lazy var BottomSelectBox = { () -> UIView in
        let tp = UIView()
        tp.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 0.4*screenSize.height)
        
        let label1 = UILabel()
        label1.text = "所有客户"
        label1.textColor = UIColor.green
        let tapGes1 = UITapGestureRecognizer()
        tapGes1.addTarget(self, action: #selector(label1Clicked))
        label1.addGestureRecognizer(tapGes1)
        
        let label2 = UILabel()
        label2.text = "重点客户"
        label2.textColor = UIColor.green
        let tapGes2 = UITapGestureRecognizer()
        tapGes2.addTarget(self, action: #selector(label2Clicked))
        label2.addGestureRecognizer(tapGes2)
        
        let label3 = UILabel()
        label3.text = "新客户"
        label3.textColor = UIColor.green
        let tapGes3 = UITapGestureRecognizer()
        tapGes3.addTarget(self, action: #selector(label3Clicked))
        label3.addGestureRecognizer(tapGes3)
        
        let label4 = UILabel()
        label4.text = "能效客户"
        label4.textColor = UIColor.green
        let tapGes4 = UITapGestureRecognizer()
        tapGes4.addTarget(self, action: #selector(label4Clicked))
        label4.addGestureRecognizer(tapGes4)
        
        let label5 = UILabel()
        label5.text = "取消"
        label5.textColor = UIColor.black
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        label5.addGestureRecognizer(tapGes)
        
        return tp
    } ()
    
    lazy var coverView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        let tp = UIView()
        tp.backgroundColor = UIColor.gray
        tp.alpha = 0.5
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(currentCustomerBtn)
        self.view.addSubview(collectionView)
    }
    
    func reGenerateView() {
        NSLog("重新生成页面")
    }
    
    @objc func currentCustomerBtnClicked() {
        NSLog("----选择客户类型----")
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        self.view.addSubview(coverView)
    }
    
    @objc func label1Clicked() {
        currentCustomerType = .allCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        coverView.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label2Clicked() {
        currentCustomerType = .importantCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        coverView.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label3Clicked() {
        currentCustomerType = .newCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        coverView.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label4Clicked() {
        currentCustomerType = .energyEfficiencyCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        coverView.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func bottomSelectBoxDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 0.4*self.screenSize.height)
        })
        coverView.removeFromSuperview()
    }
}


//extension CustomerOverviewViewController: UICollectionViewDelegatem, UICollectionViewDataSource {
//
//}
