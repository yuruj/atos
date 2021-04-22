//
//  ChangeNickNameViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/12.
//

import UIKit

class ChangeNickNameViewController: UIViewController {
    
    lazy var textfiled = { () -> UITextField in
        let tp = UITextField()
        tp.text = "金伙伴"
        tp.textColor = UIColor.black
        tp.textAlignment = NSTextAlignment.left
        tp.borderStyle = UITextField.BorderStyle.roundedRect
        tp.clearButtonMode = UITextField.ViewMode.never
        tp.frame = CGRect(x: 100, y: navHeight+1, width: screenSize.width-110, height: 48)
        tp.borderStyle = .none
        tp.backgroundColor = UIColor.white
        return tp
    } ()
    
    lazy var affirmBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("确定", for: .normal)
        tp.setTitleColor(UIColor.white, for: .normal)
        tp.backgroundColor = UIColor.green
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: 10, y: 170, width: screenSize.width-20, height: 50)
        tp.addTarget(self, action: #selector(affirmBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入编辑昵称界面----")
        self.view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let label = UILabel()
        label.text = "昵称"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect(x: 10, y: navHeight, width: 80, height: 50)
        self.view.addSubview(label)
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        lineView.frame = CGRect(x: 10, y: navHeight + 49.5, width: screenSize.width - 10, height: 1)
        self.view.addSubview(lineView)
        self.view.addSubview(textfiled)
        self.view.addSubview(affirmBtn)
    }
    
    @objc func affirmBtnClicked() {
        NSLog("----affirmBtn Clicked----")
        self.navigationController?.popViewController(animated: true)
    }
    
}
