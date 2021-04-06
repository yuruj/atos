//
//  MyViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class MyViewController: UIViewController {
    
    var userData: UserDataModel!
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var view1 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 10, y: 100, width: screenSize.width - 20, height: 80)
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view1Clicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view2 = { () -> UIView in
        let tp = UIView()
        tp.layer.cornerRadius = 5
        tp.backgroundColor = UIColor.lightGray
        tp.frame = CGRect(x: 10, y: 200, width: screenSize.width - 20, height: 60)
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view2Clicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view3 = { () -> UIView in
        let tp = UIView()
        tp.layer.cornerRadius = 5
        tp.backgroundColor = UIColor.lightGray
        tp.frame = CGRect(x: 10, y: 300, width: screenSize.width - 20, height: 60)
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view3Clicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var logoutBtn = { () -> UIButton in
        let tp = UIButton()
        tp.backgroundColor = UIColor.red
        tp.layer.cornerRadius = 5
        tp.setTitle("注销账号", for: .normal)
        tp.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
        tp.frame = CGRect(x: 80, y: 400, width: screenSize.width - 160, height: 60)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        self.view.addSubview(logoutBtn)
    }
    
    @objc func view1Clicked() {
        NSLog("----view1 clicked-----")
        let vc = MyViewView1Controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func view2Clicked() {
        NSLog("----view2 clicked-----")
        let vc = MyViewView2Controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func view3Clicked() {
        NSLog("----view3 clicked-----")
        let vc = MyViewView3Controller()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logoutBtnClicked() {
        NSLog("----logoutBtn clicked-----")
    }
}

struct UserDataModel {
    var headPortrait: String
    var nickName: String
    var phoneNumber: String
    var email: String
    
    init(hp: String = "", nn: String = "金伙伴", pn: String = "13587026301", em: String = "879410993@qq.com") {
        self.headPortrait = hp
        self.nickName = nn
        self.phoneNumber = pn
        self.email = em
    }
}
