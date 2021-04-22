//
//  WarnViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class WarnViewController: UIViewController {
    
    var selectIndex: Int = 0
    
    lazy var scrollView = { () -> UIScrollView in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        let tp = UIScrollView()
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        tp.refreshControl = refreshControl
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tp.delegate = self
        return tp
    } ()
    
    lazy var navView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 60)
        return tp
    } ()
    
    lazy var todayBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("今日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        tp.layer.cornerRadius = 5
        tp.frame = CGRect(x: screenSize.width - 170, y: 15, width: 50, height: 30)
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
        tp.frame = CGRect(x: screenSize.width - 115, y: 15, width: 50, height: 30)
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
        tp.frame = CGRect(x: screenSize.width - 60, y: 15, width: 50, height: 30)
        tp.addTarget(self, action: #selector(recentBtnClicked), for: .touchUpInside)
        return tp
    } ()
    
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
        tp.frame = CGRect(x: 10, y: 5, width: 80, height: 50)
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
        tp.frame = CGRect(x: 100, y: 5, width: 80, height: 50)
        tp.isUserInteractionEnabled = true
        return tp
    } ()
    
    lazy var datePicker1 = { () -> UIDatePicker in
        let tp = UIDatePicker()
        tp.frame = CGRect(x: 10, y: 5, width: 120, height: 50)
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
        tp.frame = CGRect(x: 100, y: 5, width: 80, height: 50)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshBtns()
    }
    
    func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(navView)
        self.scrollView.addSubview(time1Label)
        self.scrollView.addSubview(time2Label)
        self.scrollView.addSubview(todayBtn)
        self.scrollView.addSubview(yesterdayBtn)
        self.scrollView.addSubview(recentBtn)
        self.scrollView.addSubview(datePicker1)
        self.scrollView.addSubview(datePicker2)
        
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(searchViewClicked))
        let searchView = SearchLabelView(frame: CGRect(x: 0, y: 70, width: screenSize.width, height: 50))
        searchView.addGestureRecognizer(tapGes)
        searchView.backgroundColor = UIColor.clear
        searchView.label.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.text = "暂无数据"
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 150, width: screenSize.width, height: 50)
        let imageView = UIImageView(image: UIImage(named: "empty"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: screenSize.width / 3 - 20, y: 200, width: screenSize.width / 3 + 40, height: screenSize.width / 3 + 40)
        
        self.scrollView.addSubview(searchView)
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(imageView)
        
        let charView = UILabel()
        charView.text = "~"
        charView.textAlignment = .center
        charView.frame = CGRect(x: 70, y: 5, width: 50, height: 50)
        self.scrollView.addSubview(charView)
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
        self.scrollView.addSubview(datePicker1)
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
        self.scrollView.addSubview(datePicker2)
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
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func searchViewClicked() {
        NSLog("----searchView Clicked----")
        let vc = SearchViewController()
        vc.title = "企业搜索"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WarnViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
}
