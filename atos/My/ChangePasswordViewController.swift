//
//  ChangePasswordViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/7.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var backgroundView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: 150)
        let label1 = UILabel()
        label1.text = "旧密码"
        label1.textColor = UIColor.black
        label1.frame = CGRect(x: 10, y: 0, width: 100, height: 50)
        let label2 = UILabel()
        label2.text = "新密码"
        label2.textColor = UIColor.black
        label2.frame = CGRect(x: 10, y: 50, width: 100, height: 50)
        let label3 = UILabel()
        label3.text = "确认密码"
        label3.textColor = UIColor.black
        label3.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        let line1 = UIView()
        line1.backgroundColor = UIColor.lightGray
        line1.frame = CGRect(x: 10, y: 49.5, width: screenSize.width, height: 1)
        let line2 = UIView()
        line2.backgroundColor = UIColor.lightGray
        line2.frame = CGRect(x: 10, y: 99.5, width: screenSize.width, height: 1)
        tp.addSubview(label1)
        tp.addSubview(label2)
        tp.addSubview(label3)
        tp.addSubview(line1)
        tp.addSubview(line2)
        return tp
    } ()
    
    lazy var textfiled1 = { () -> UITextField in
        let tp = UITextField()
        tp.text = ""
        tp.textColor = UIColor.gray
        tp.placeholder = "请填写旧密码"
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.frame = CGRect(x: 100, y: navHeight+1, width: screenSize.width-110, height: 48)
        tp.borderStyle = .none
        tp.isSecureTextEntry = true
        tp.backgroundColor = UIColor.white
        return tp
    } ()
    
    lazy var textfiled2 = { () -> UITextField in
        let tp = UITextField()
        tp.text = ""
        tp.textColor = UIColor.gray
        tp.placeholder = "请填写新密码"
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.frame = CGRect(x: 100, y: navHeight+50+1, width: screenSize.width-110, height: 48)
        tp.borderStyle = .none
        tp.isSecureTextEntry = true
        tp.backgroundColor = UIColor.white
        return tp
    } ()
    
    lazy var textfield3 = { () -> UITextField in
        let tp = UITextField()
        tp.text = ""
        tp.textColor = UIColor.gray
        tp.placeholder = "请填确认密码"
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.frame = CGRect(x: 100, y: navHeight+100+1, width: screenSize.width-110, height: 48)
        tp.borderStyle = .none
        tp.isSecureTextEntry = true
        tp.backgroundColor = UIColor.white
        return tp
    } ()
    
    lazy var affirmBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("确定", for: .normal)
        tp.setTitleColor(UIColor.white, for: .normal)
        tp.backgroundColor = UIColor.green
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: 10, y: 270, width: screenSize.width-20, height: 50)
        tp.addTarget(self, action: #selector(affirmBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(backgroundView)
        self.view.addSubview(textfiled1)
        self.view.addSubview(textfiled2)
        self.view.addSubview(textfield3)
        self.view.addSubview(affirmBtn)
    }
    
    func check() -> Bool {
        return true
    }
    
    @objc func affirmBtnClicked() {
        NSLog("----affirmBtn Clicked----")
        NSLog("----text1 \(textfiled1.text!)----")
        NSLog("----text2 \(textfiled2.text!)----")
        NSLog("----text3 \(textfield3.text!)----")
        if check() {
            NSLog("----密码修改成功----")
            self.navigationController?.popViewController(animated: true)
        } else {
            NSLog("----密码修改失败----")
        }
    }
}
