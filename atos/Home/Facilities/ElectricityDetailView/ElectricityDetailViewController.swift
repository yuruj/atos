//
//  ElectricityDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/19.
//

import UIKit
import AAInfographics
import Alamofire
import SwiftyJSON

class ElectricityDetailViewController: UIViewController {
    
    let selectViewHeight: CGFloat = 50
    let selectBtnWidth: CGFloat = (screenSize.width - 20) / 3
    
    lazy var selectView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor(red: 235, green: 236, blue: 239)
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: selectViewHeight)
        return tp
    } ()
    
    lazy var selectBtn1 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("电表概览", for: .normal)
        tp.setTitleColor(UIColor(red: 89, green: 191, blue: 193), for: .normal)
        tp.backgroundColor = UIColor.clear
        tp.frame = CGRect(x: 10, y: navHeight, width: selectBtnWidth, height: selectViewHeight)
        tp.addTarget(self, action: #selector(selectBtn1Clicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var selectBtn2 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("曲线详情", for: .normal)
        tp.setTitleColor(UIColor(red: 89, green: 191, blue: 193), for: .normal)
        tp.backgroundColor = UIColor.clear
        tp.frame = CGRect(x: 10 + selectBtnWidth, y: navHeight, width: selectBtnWidth, height: selectViewHeight)
        tp.addTarget(self, action: #selector(selectBtn2Clicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var selectBtn3 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("参数配置", for: .normal)
        tp.setTitleColor(UIColor(red: 89, green: 191, blue: 193), for: .normal)
        tp.backgroundColor = UIColor.clear
        tp.frame = CGRect(x: 10 + selectBtnWidth * 2, y: navHeight, width: selectBtnWidth, height: selectViewHeight)
        tp.addTarget(self, action: #selector(selectBtn3Clicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var selectLineView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor(red: 89, green: 191, blue: 193)
        tp.frame = CGRect(x: 20, y: navHeight + selectViewHeight - 3, width: selectBtnWidth - 20, height: 3)
        tp.layer.cornerRadius = 1.5
        return tp
    } ()
    
    lazy var view1 = { () -> ElectricityDetailView1 in
        let tp = ElectricityDetailView1(frame: CGRect(x: 0, y: navHeight + selectViewHeight, width: screenSize.width, height: screenSize.height - navHeight + selectViewHeight))
        return tp
    } ()
    
    lazy var view2 = { () -> ElectricityDetailView2 in
        let tp = ElectricityDetailView2(frame: CGRect(x: 0, y: navHeight + selectViewHeight, width: screenSize.width, height: screenSize.height - navHeight + selectViewHeight))
        return tp
    } ()
    
    lazy var view3 = { () -> ElectricityDetailView3 in
        let tp = ElectricityDetailView3(frame: CGRect(x: 0, y: navHeight + selectViewHeight, width: screenSize.width, height: screenSize.height - navHeight + selectViewHeight))
        return tp
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(selectView)
        self.view.addSubview(selectBtn1)
        self.view.addSubview(selectBtn2)
        self.view.addSubview(selectBtn3)
        self.view.addSubview(selectLineView)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
    }
    
    @objc func selectBtn1Clicked() {
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.selectLineView.frame = CGRect(x: 20, y: navHeight + self.selectViewHeight - 3, width: self.selectBtnWidth - 20, height: 3)
        }
    }
    
    @objc func selectBtn2Clicked() {
        view1.isHidden = true
        view2.isHidden = false
        view3.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.selectLineView.frame = CGRect(x: 20 + self.selectBtnWidth, y: navHeight + self.selectViewHeight - 3, width: self.selectBtnWidth - 20, height: 3)
        }
    }
    
    @objc func selectBtn3Clicked() {
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.selectLineView.frame = CGRect(x: 20 + self.selectBtnWidth * 2, y: navHeight + self.selectViewHeight - 3, width: self.selectBtnWidth - 20, height: 3)
        }
    }
    
}

extension ElectricityDetailViewController: UIScrollViewDelegate {
    
}
