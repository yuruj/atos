//
//  LaunchViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class LaunchViewController: UIViewController {
    
    let accountKey: String = "savedAccountKey"
        
    var isSavedAccount: Bool = false
    
    var completionHandler: (() -> ())!
    
    lazy var accountField = { () -> UITextField in
        let tp = UITextField()
        tp.text = ""
        tp.textColor = UIColor.gray
        tp.placeholder = "请输入账号"
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.frame = CGRect(x: screenSize.width / 2 - 125, y: screenSize.height / 2 - 100, width: 250, height: 40)
        return tp
    } ()
    
    lazy var passwordField = { () -> UITextField in
        let tp = UITextField()
        tp.text = ""
        tp.textColor = UIColor.gray
        tp.placeholder = "请输入密码"
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.isSecureTextEntry = true
        tp.frame = CGRect(x: screenSize.width / 2 - 125, y: screenSize.height / 2 - 30, width: 250, height: 40)
        return tp
    } ()
    
    lazy var loginBtn = { () ->  UIButton in
        let tp = UIButton()
        tp.setTitle("登录", for: .normal)
        tp.backgroundColor = UIColor.red
        tp.layer.cornerRadius = 10
        tp.frame = CGRect(x: screenSize.width / 2 - 100, y: screenSize.height / 2 + 50, width: 200, height: 40)
        tp.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var rememberPasswordBtn = { () -> UIButton in
        let tp = UIButton()
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoView = UIImageView(image: UIImage(named: "logo"))
        logoView.contentMode = .scaleAspectFit
        logoView.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.height / 2 - 280, width: 100, height: 100)
        self.view.addSubview(logoView)
        self.view.addSubview(accountField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginBtn)
        checkSavedAccount()
    }
    
    func checkPassword() -> Bool {
        let account = accountField.text
        let password = passwordField.text
        
        let urlStr = testURL + ""
        let head: HTTPHeaders = ["Authorization": "Basic Y2xpZW50OnNlY3JldA=="]
        let par: Parameters = [
            "username": "",
            "password": "",
            "grant_type": "",
            "scope": ""
        ]
        AF.request(urlStr, method: .get, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let jsonObj = JSON.init(json)
                
            case let .failure(error):
                print(error)
            }
        }
        return true
    }
    
    func checkSavedAccount() {
        if UserDefaults.standard.object(forKey: accountKey) != nil {
            NSLog("----已有账号密码----")
            let accountInformation = UserDefaults.standard.object(forKey: accountKey) as! (String, String)
            accountField.text = accountInformation.0
            passwordField.text = accountInformation.1
            isSavedAccount = true
        }
    }
    
    @objc func loginBtnClicked() {
        NSLog("----loginBtn Clicked----")
//        if checkPassword() {
//            if isSavedAccount {
//                let accountInformation: (String, String) = (account: accountField.text!, password: passwordField.text!)
//                UserDefaults.standard.set(accountInformation, forKey: accountKey)
//            }
//            self.navigationController?.popViewController(animated: false)
//        }
        completionHandler()
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func rememberPasswordBtnClicked() {
        NSLog("----remember password----")
        if isSavedAccount {
            isSavedAccount = false
        } else {
            isSavedAccount = true
        }
    }
    
}
