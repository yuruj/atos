//
//  ViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.textColor = UIColor.black
        tp.font = UIFont.boldSystemFont(ofSize: 23)
        tp.text = "首页"
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let bar = UITabBar()
        self.setValue(bar, forKey: "tabBar")
        
        addHomeVC()
        addWarnVC()
        addMyVC()
        
        self.selectedIndex = 0
        
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLaunchVC()
    }
    
    private func addLaunchVC() {
        if (!UserDefaults.standard.bool(forKey: "firstLaunch") && false) {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            let vc = LaunchViewController()
            vc.hidesBottomBarWhenPushed = true
            let homevc = self.children[0] as! UINavigationController
            homevc.pushViewController(vc, animated: false)
        } else {
            
        }
    }
    
    
    private func addHomeVC() {
        let vc = HomeViewController()
        vc.view.backgroundColor = UIColor.white
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = nil
        cvc.navigationBar.isHidden = true
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "首页"
        cvc.tabBarItem.tag = 0
        
        self.addChild(cvc)
    }
    
    private func addWarnVC() {
        let vc = WarnViewController()
        vc.view.backgroundColor = UIColor.white
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = nil
        cvc.navigationBar.isHidden = true
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "警告"
        cvc.tabBarItem.tag = 1
        
        self.addChild(cvc)
    }
    
    private func addMyVC() {
        let vc = MyViewController()
        vc.view.backgroundColor = UIColor.white
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = nil
        cvc.navigationBar.isHidden = true
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "我的"
        cvc.tabBarItem.tag = 2
        
        self.addChild(cvc)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NSLog("yrj tabBar \(item.tag)")
        NSLog("测试统计代码行数")
    }
    
}

