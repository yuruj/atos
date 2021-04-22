//
//  WarnDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/22.
//

import UIKit

class WarnDetailViewController: UIViewController {
    
    var selectIndex = 0
    
    lazy var time1Label = { () -> UILabel in
        let tp = UILabel()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        tp.text = str
        tp.textColor = UIColor(red: 89, green: 189, blue: 191)
        tp.font = UIFont.boldSystemFont(ofSize: 12)
        tp.textAlignment = .center
        tp.frame = CGRect(x: 10, y: 5 + navHeight, width: 80, height: 50)
        tp.isUserInteractionEnabled = true
        return tp
    } ()
    
    lazy var time2Label = { () -> UILabel in
        let tp = UILabel()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        tp.text = str
        tp.textColor = UIColor(red: 89, green: 189, blue: 191)
        tp.font = UIFont.boldSystemFont(ofSize: 12)
        tp.textAlignment = .center
        tp.frame = CGRect(x: 100, y: 5 + navHeight, width: 80, height: 50)
        tp.isUserInteractionEnabled = true
        return tp
    } ()
    
    lazy var datePicker1 = { () -> UIDatePicker in
        let tp = UIDatePicker()
        tp.frame = CGRect(x: 10, y: 5 + navHeight, width: 120, height: 50)
        tp.datePickerMode = UIDatePicker.Mode.date
        tp.setDate(Date(), animated: true)
        tp.minimumDate = Date(timeInterval: -93312000, since: Date())
        tp.maximumDate = Date(timeIntervalSinceNow: 93312000)
        tp.minuteInterval = 5
        tp.backgroundColor = nil
        tp.locale = Locale.init(identifier: "zh_CN")
        tp.addTarget(self, action: #selector(changeTime1Label), for: .valueChanged)
        tp.alpha = 0.02
        return tp
    } ()
    
    lazy var datePicker2 = { () -> UIDatePicker in
        let tp = UIDatePicker()
        tp.frame = CGRect(x: 100, y: 5 + navHeight, width: 80, height: 50)
        tp.datePickerMode = UIDatePicker.Mode.date
        tp.setDate(Date(), animated: true)
        tp.minimumDate = Date(timeInterval: -93312000, since: Date())
        tp.maximumDate = Date(timeIntervalSinceNow: 93312000)
        tp.minuteInterval = 5
        tp.backgroundColor = nil
        tp.locale = Locale.init(identifier: "zh_CN")
        tp.addTarget(self, action: #selector(changeTime2Label), for: .valueChanged)
        tp.alpha = 0.02
        return tp
    } ()
    
    lazy var todayBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("今日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: screenSize.width - 170, y: 15 + navHeight, width: 50, height: 30)
        tp.addTarget(self, action: #selector(todayBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var yesterdayBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("昨日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: screenSize.width - 115, y: 15 + navHeight, width: 50, height: 30)
        tp.addTarget(self, action: #selector(yesterdayBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var recentBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("近7日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: screenSize.width - 60, y: 15 + navHeight, width: 50, height: 30)
        tp.addTarget(self, action: #selector(recentBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshBtns()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        self.view.addSubview(time1Label)
        self.view.addSubview(time2Label)
        self.view.addSubview(todayBtn)
        self.view.addSubview(yesterdayBtn)
        self.view.addSubview(recentBtn)
        self.view.addSubview(datePicker1)
        self.view.addSubview(datePicker2)
    }
    
    func refreshBtns() {
        todayBtn.isSelected = selectIndex == 0 ? true : false
        yesterdayBtn.isSelected = selectIndex == 1 ? true : false
        recentBtn.isSelected = selectIndex == 2 ? true : false
        todayBtn.backgroundColor = selectIndex == 0 ?  UIColor(red: 89, green: 189, blue: 191) : UIColor(red: 239, green: 242, blue: 252)
        yesterdayBtn.backgroundColor = selectIndex == 1 ?  UIColor(red: 89, green: 189, blue: 191) : UIColor(red: 239, green: 242, blue: 252)
        recentBtn.backgroundColor = selectIndex == 2 ?  UIColor(red: 89, green: 189, blue: 191) : UIColor(red: 239, green: 242, blue: 252)
    }
    
    @objc func changeTime1Label() {
        let date = datePicker1.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time1Label.text = str
        datePicker1.removeFromSuperview()
        self.view.addSubview(datePicker1)
        selectIndex = -1
        refreshBtns()
        NSLog("----time1 \(str)----")
    }
    
    @objc func changeTime2Label() {
        let date = datePicker2.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time2Label.text = str
        datePicker2.removeFromSuperview()
        self.view.addSubview(datePicker2)
        selectIndex = -1
        refreshBtns()
        NSLog("----time2 \(str)----")
    }
    
    @objc func todayBtnClicked() {
        NSLog("----today clicked----")
        selectIndex = 0
        refreshBtns()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time1Label.text = str
        time2Label.text = str
        datePicker1.date = date
        datePicker2.date = date
    }
    
    @objc func yesterdayBtnClicked() {
        NSLog("----yesterday clicked----")
        selectIndex = 1
        refreshBtns()
        let date = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 24 * 60 * 60)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time1Label.text = str
        time2Label.text = str
        datePicker1.date = date
        datePicker2.date = date
    }
    
    @objc func recentBtnClicked() {
        NSLog("----recent clicked----")
        selectIndex = 2
        refreshBtns()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 24 * 60 * 60 * 7)
        let date2 = Date()
        let str1 = dateFormatter.string(from: date1)
        let str2 = dateFormatter.string(from: date2)
        time1Label.text = str1
        time2Label.text = str2
        datePicker1.date = date1
        datePicker2.date = date2
    }
    
}
