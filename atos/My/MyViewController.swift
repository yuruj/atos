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
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view1Clicked))
        let tp = UIView()
        tp.backgroundColor = nil
        tp.layer.cornerRadius = 5
        let titleLabel = UILabel()
        titleLabel.text = "金伙伴"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.frame = CGRect(x: 0, y: 10, width: 200, height: 30)
        tp.addSubview(titleLabel)
        let phoneLabel = UILabel()
        phoneLabel.text = "191****4966"
        phoneLabel.font = UIFont.systemFont(ofSize: 13)
        phoneLabel.frame = CGRect(x: 0, y: 40, width: 200, height: 30)
        tp.addSubview(phoneLabel)
        let imageView = UIImageView(image: UIImage(named: "hp"))
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: screenSize.width - 120, y: 10, width: 60, height: 60)
        tp.addSubview(imageView)
        let arrowView = UIImageView(image: UIImage(named: "arrow"))
        arrowView.contentMode = .scaleAspectFill
        arrowView.frame = CGRect(x: screenSize.width - 50, y: 25, width: 30, height: 30)
        tp.addSubview(arrowView)
        tp.frame = CGRect(x: 15, y: 100, width: screenSize.width - 30, height: 80)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view2 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view2Clicked))
        let tp = UIView()
        tp.layer.cornerRadius = 5
        tp.backgroundColor = UIColor(red: 244, green: 244, blue: 244)
        let imageView = UIImageView(image: UIImage(named: "user_center_safe"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 20, y: 15, width: 30, height: 30)
        tp.addSubview(imageView)
        let titleLabel = UILabel()
        titleLabel.text = "安全中心"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.frame = CGRect(x: 70, y: 20, width: 80, height: 20)
        tp.addSubview(titleLabel)
        tp.frame = CGRect(x: 15, y: 210, width: screenSize.width - 30, height: 60)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view3 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(view3Clicked))
        let tp = UIView()
        tp.layer.cornerRadius = 5
        tp.backgroundColor = UIColor(red: 244, green: 244, blue: 244)
        let imageView = UIImageView(image: UIImage(named: "user_center_about"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 20, y: 15, width: 30, height: 30)
        tp.addSubview(imageView)
        let titleLabel = UILabel()
        titleLabel.text = "关于我们"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.frame = CGRect(x: 70, y: 20, width: 80, height: 20)
        tp.addSubview(titleLabel)
        tp.frame = CGRect(x: 15, y: 280, width: screenSize.width - 30, height: 60)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var logoutBtn = { () -> UIButton in
        let tp = UIButton()
        tp.backgroundColor = UIColor(red: 230, green: 109, blue: 91)
        tp.layer.cornerRadius = 25
        tp.setTitle("注销账号", for: .normal)
        tp.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)
        tp.frame = CGRect(x: 60, y: 700, width: screenSize.width - 120, height: 50)
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
        vc.title = "基本信息"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func view2Clicked() {
        NSLog("----view2 clicked-----")
        let vc = MyViewView2Controller()
        vc.title = "安全中心"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func view3Clicked() {
        NSLog("----view3 clicked-----")
        let vc = MyViewView3Controller()
        vc.title = "联系方式"
        vc.hidesBottomBarWhenPushed = true
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
