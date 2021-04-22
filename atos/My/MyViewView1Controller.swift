//
//  MyViewView1Controller.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class MyViewView1Controller: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var headPortraitView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(hpViewClicked))
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: 80)
        let titleLabel = UILabel()
        titleLabel.text = "头像"
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 80)
        tp.addSubview(titleLabel)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var nickNameView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(nnViewClicked))
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight + 80, width: screenSize.width, height: 60)
        let titleLabel = UILabel()
        titleLabel.text = "昵称"
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 60)
        tp.addSubview(titleLabel)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var phoneNumberView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(pnViewClicked))
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight + 140, width: screenSize.width, height: 60)
        let titleLabel = UILabel()
        titleLabel.text = "手机号"
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 60)
        tp.addSubview(titleLabel)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var emailView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(emViewClicked))
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight + 200, width: screenSize.width, height: 60)
        let titleLabel = UILabel()
        titleLabel.text = "邮箱"
        titleLabel.textColor = UIColor.black
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 60)
        tp.addSubview(titleLabel)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入view1----")
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(headPortraitView)
        self.view.addSubview(nickNameView)
        self.view.addSubview(phoneNumberView)
        self.view.addSubview(emailView)
        setupUI()
    }
    
    func setupUI() {
        let line1 = UIView()
        line1.backgroundColor = UIColor.black
        line1.frame = CGRect(x: 10, y: navHeight + 80, width: screenSize.width - 10, height: 0.5)
        let line2 = UIView()
        line2.backgroundColor = UIColor.black
        line2.frame = CGRect(x: 10, y: navHeight + 140, width: screenSize.width - 10, height: 0.5)
        let line3 = UIView()
        line3.backgroundColor = UIColor.black
        line3.frame = CGRect(x: 10, y: navHeight + 200, width: screenSize.width - 10, height: 0.5)
        let line4 = UIView()
        line4.backgroundColor = UIColor.black
        line4.frame = CGRect(x: 10, y: navHeight + 260, width: screenSize.width - 10, height: 0.5)
        self.view.addSubview(line1)
        self.view.addSubview(line2)
        self.view.addSubview(line3)
        self.view.addSubview(line4)
    }
    
    @objc func hpViewClicked() {
        NSLog("----hpView clicked----")
        let vc = ChangeHeadPortraitViewController()
        vc.title = "修改头像"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nnViewClicked() {
        NSLog("----nnView clicked----")
        let vc = ChangeNickNameViewController()
        vc.title = "修改昵称"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pnViewClicked() {
        NSLog("----pnView clicked----")
        let vc = ChangePhoneNumberViewController()
        vc.title = "修改手机号"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func emViewClicked() {
        NSLog("----emView clicked----")
        let vc = ChangeEmailViewController()
        vc.title = "修改邮箱"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
