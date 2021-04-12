//
//  LaunchViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let accountKey: String = "savedAccountKey"
        
    var isSavedAccount: Bool = false
    
    lazy var accountField = { () -> UITextField in
        let tp = UITextField()
        return tp
    } ()
    
    lazy var passwordField = { () -> UITextField in
        let tp = UITextField()
        return tp
    } ()
    
    lazy var loginBtn = { () ->  UIButton in
        let tp = UIButton()
        return tp
    } ()
    
    lazy var rememberPasswordBtn = { () -> UIButton in
        let tp = UIButton()
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(accountField)
        self.view.addSubview(passwordField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(rememberPasswordBtn)
        checkSavedAccount()
    }
    
    func checkPassword() -> Bool {
        let account = accountField.text
        let password = passwordField.text
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
        if checkPassword() {
            if isSavedAccount {
                let accountInformation: (String, String) = (account: accountField.text!, password: passwordField.text!)
                UserDefaults.standard.set(accountInformation, forKey: accountKey)
            }
            self.navigationController?.popViewController(animated: false)
        }
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
