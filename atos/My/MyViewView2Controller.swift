//
//  MyViewView2Controller.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class MyViewView2Controller: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var changePasswordView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(changePasswirdViewClicked))
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: 50)
        let titleLabel = UILabel()
        titleLabel.text = "修改密码"
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 50)
        tp.addSubview(titleLabel)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入view2----")
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(changePasswordView)
    }
    
    @objc func changePasswirdViewClicked() {
        NSLog("----修改密码----")
        let vc = ChangePasswordViewController()
        vc.title = "修改密码"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
