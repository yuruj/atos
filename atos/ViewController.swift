//
//  ViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

let navHeight: CGFloat = 91
let screenSize = UIScreen.main.bounds.size
let token: String = ""
let testURL = "http://dev.voltmao.com:16080"
let URL = "https://api.voltmao.com"

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
        
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
        
        addLaunchVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addLaunchVC() {
        if (true || !UserDefaults.standard.bool(forKey: "firstLaunch")) {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            let vc = LaunchViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.completionHandler = { () in
                let homevc = self.children[0] as! UINavigationController
                homevc.navigationBar.isHidden = false
            }
            let homevc = self.children[0] as! UINavigationController
            homevc.navigationBar.isHidden = true
            homevc.pushViewController(vc, animated: false)
        } else {

        }
    }
    
    private func addHomeVC() {
        let vc = HomeViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = "首页"
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = nil
        cvc.navigationBar.isHidden = false
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "首页"
        cvc.tabBarItem.tag = 0
        cvc.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        cvc.tabBarItem.selectedImage = UIImage(named: "home_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        self.addChild(cvc)
    }
    
    private func addWarnVC() {
        let vc = WarnViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = "告警"
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = nil
        cvc.navigationBar.isHidden = false
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "警告"
        cvc.tabBarItem.tag = 1
        cvc.tabBarItem.image = UIImage(named: "warn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        cvc.tabBarItem.selectedImage = UIImage(named: "warn_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        self.addChild(cvc)
    }
    
    private func addMyVC() {
        let vc = MyViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = "个人中心"
        
        let cvc = UINavigationController(rootViewController: vc)
        cvc.navigationBar.barTintColor = UIColor.white
        cvc.navigationBar.isHidden = false
        cvc.navigationBar.setValue(true, forKey: "hidesShadow")
//        cvc.navigationItem.backBarButtonItem = nil
        cvc.tabBarItem.title = "我的"
        cvc.tabBarItem.tag = 2
        cvc.tabBarItem.image = UIImage(named: "my")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        cvc.tabBarItem.selectedImage = UIImage(named: "my_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        self.addChild(cvc)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NSLog("----yrj tabBar \(item.tag)----")
    }
    
}

