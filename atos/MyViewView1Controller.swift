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
        let tp = UIView()
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(hpViewClicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var nickNameView = { () -> UIView in
        let tp = UIView()
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(nnViewClicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var phoneNumberView = { () -> UIView in
        let tp = UIView()
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(pnViewClicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var emailView = { () -> UIView in
        let tp = UIView()
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(emViewClicked))
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入view1----")
        self.view.addSubview(headPortraitView)
        self.view.addSubview(nickNameView)
        self.view.addSubview(phoneNumberView)
        self.view.addSubview(emailView)
    }
    
    @objc func hpViewClicked() {
        NSLog("----hpView clicked----")
    }
    
    @objc func nnViewClicked() {
        NSLog("----nnView clicked----")
    }
    
    @objc func pnViewClicked() {
        NSLog("----pnView clicked----")
    }
    
    @objc func emViewClicked() {
        NSLog("----emView clicked----")
    }
}
