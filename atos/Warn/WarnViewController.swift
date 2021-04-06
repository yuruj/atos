//
//  WarnViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class WarnViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    var selectIndex: Int = 0
    
    lazy var scrollView = { () -> UIScrollView in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        let tp = UIScrollView()
        tp.backgroundColor = UIColor.gray
        tp.refreshControl = refreshControl
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tp.delegate = self
        return tp
    } ()
    
    lazy var navView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 80)
        return tp
    } ()
    
    lazy var todayBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("今日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: 200, y: 25, width: 50, height: 30)
        tp.addTarget(self, action: #selector(todayBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var yesterdayBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("昨日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: 280, y: 25, width: 50, height: 30)
        tp.addTarget(self, action: #selector(yesterdayBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var recentBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("近7日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: 360, y: 25, width: 50, height: 30)
        tp.addTarget(self, action: #selector(recentBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
    lazy var time1Label = { () -> UILabel in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(time1LabelClicked))
        let tp = UILabel()
        tp.text = "2021-04-06"
        tp.textColor = UIColor.black
        tp.font = UIFont.boldSystemFont(ofSize: 15)
        tp.textAlignment = .center
        tp.frame = CGRect(x: 10, y: 25, width: 80, height: 50)
//        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var time2Label = { () -> UILabel in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(time2LabelClicked))
        let tp = UILabel()
        tp.text = "2021-04-06"
        tp.textColor = UIColor.black
        tp.font = UIFont.boldSystemFont(ofSize: 15)
        tp.textAlignment = .center
        tp.frame = CGRect(x: 100, y: 25, width: 80, height: 50)
//        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var datePicker = { () -> UIDatePicker in
        let tp = UIDatePicker()
        resetDatePicker()
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.view.addSubview(time1Label)
        self.scrollView.addSubview(time2Label)
        self.scrollView.addSubview(navView)
        self.scrollView.addSubview(todayBtn)
        self.scrollView.addSubview(yesterdayBtn)
        self.scrollView.addSubview(recentBtn)
        refreshBtns()
    }
    
    func refreshBtns() {
        todayBtn.isSelected = selectIndex == 0 ? true : false
        yesterdayBtn.isSelected = selectIndex == 1 ? true : false
        recentBtn.isSelected = selectIndex == 2 ? true : false
        todayBtn.backgroundColor = selectIndex == 0 ? UIColor.green : UIColor.lightGray
        yesterdayBtn.backgroundColor = selectIndex == 1 ? UIColor.green : UIColor.lightGray
        recentBtn.backgroundColor = selectIndex == 2 ? UIColor.green : UIColor.lightGray
    }
    
    func resetDatePicker() {
        datePicker.backgroundColor = UIColor.lightGray
        datePicker.datePickerMode = .date
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = Date(timeInterval: -93312000, since: Date())
        datePicker.maximumDate = Date(timeIntervalSinceNow: 93312000)
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 300)
    }
    
    @objc func time1LabelClicked() {
        NSLog("----time1Label clicked----")
        resetDatePicker()
        datePicker.addTarget(self, action: #selector(changeTime1Label), for: .valueChanged)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.addSubview(self.datePicker)
            self.datePicker.frame = CGRect(x: 0, y: self.screenSize.height - 300, width: self.screenSize.width, height: 300)
        })
    }
    
    @objc func time2LabelClicked() {
        NSLog("----time2Label clicked----")
        resetDatePicker()
        datePicker.addTarget(self, action: #selector(changeTime2Label), for: .valueChanged)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.addSubview(self.datePicker)
            self.datePicker.frame = CGRect(x: 0, y: self.screenSize.height - 300, width: self.screenSize.width, height: 300)
        })
    }
    
    @objc func changeTime1Label() {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time1Label.text = str
        datePicker.removeTarget(self, action: #selector(changeTime1Label), for: .valueChanged)
        datePicker.removeFromSuperview()
        NSLog("----time1 \(str)----")
    }
    
    @objc func changeTime2Label() {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        time2Label.text = str
        datePicker.removeTarget(self, action: #selector(changeTime2Label), for: .valueChanged)
        datePicker.removeFromSuperview()
        NSLog("----time2 \(str)----")
    }
    
    @objc func todayBtnClicked() {
        NSLog("----today clicked----")
        selectIndex = 0
        refreshBtns()
    }
    
    @objc func yesterdayBtnClicked() {
        NSLog("----yesterday clicked----")
        selectIndex = 1
        refreshBtns()
    }
    
    @objc func recentBtnClicked() {
        NSLog("----recent clicked----")
        selectIndex = 2
        refreshBtns()
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
}

extension WarnViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
}
