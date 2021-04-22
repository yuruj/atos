//
//  SensorDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/19.
//

import UIKit

class SensorDetailViewController: UIViewController {
    
    var selectIndex: Int = 0
    
    let btnWidth: CGFloat = (screenSize.width - 30) / 5
    
    lazy var btn1 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("今日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.frame = CGRect(x: 15, y: 25 + navHeight, width: btnWidth, height: 30)
        tp.addTarget(self, action: #selector(btn1Clicked), for: .touchUpInside)
        tp.layer.cornerRadius = 5
        return tp
    } ()
    
    lazy var btn2 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("昨日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.frame = CGRect(x: 15 + btnWidth, y: 25 + navHeight, width: btnWidth, height: 30)
        tp.addTarget(self, action: #selector(btn2Clicked), for: .touchUpInside)
        tp.layer.cornerRadius = 5
        return tp
    } ()
    
    lazy var btn3 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("近三日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.frame = CGRect(x: 15 + btnWidth * 2, y: 25 + navHeight, width: btnWidth, height: 30)
        tp.addTarget(self, action: #selector(btn3Clicked), for: .touchUpInside)
        tp.layer.cornerRadius = 5
        return tp
    } ()
    
    lazy var btn4 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("近七日", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.frame = CGRect(x: 15 + btnWidth * 3, y: 25 + navHeight, width: btnWidth, height: 30)
        tp.addTarget(self, action: #selector(btn4Clicked), for: .touchUpInside)
        tp.layer.cornerRadius = 5
        return tp
    } ()
    
    lazy var btn5 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("近一月", for: .normal)
        tp.setTitleColor(UIColor.white, for: .selected)
        tp.setTitleColor(UIColor.gray, for: .normal)
        tp.frame = CGRect(x: 15 + btnWidth * 4, y: 25 + navHeight, width: btnWidth, height: 30)
        tp.addTarget(self, action: #selector(btn5Clicked), for: .touchUpInside)
        tp.layer.cornerRadius = 5
        return tp
    } ()
    
    lazy var time1Label = { () -> UILabel in
        let tp = UILabel()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        tp.text = str
        tp.textColor = UIColor(red: 89, green: 191, blue: 193)
        tp.font = UIFont.boldSystemFont(ofSize: 10)
        tp.textAlignment = .center
        tp.frame = CGRect(x: screenSize.width / 2 - 90, y: 70 + navHeight, width: 80, height: 15)
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
        tp.textColor = UIColor(red: 89, green: 191, blue: 193)
        tp.font = UIFont.boldSystemFont(ofSize: 10)
        tp.textAlignment = .center
        tp.frame = CGRect(x: screenSize.width / 2 + 10, y: 70 + navHeight, width: 80, height: 15)
        tp.isUserInteractionEnabled = true
        return tp
    } ()
    
    lazy var datePicker1 = { () -> UIDatePicker in
        let tp = UIDatePicker()
        tp.frame = CGRect(x: screenSize.width / 2 - 90, y: 70 + navHeight, width: 80, height: 15)
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
        tp.frame = CGRect(x: screenSize.width / 2 + 10, y: 70 + navHeight, width: 80, height: 15)
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
    
    lazy var currentLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "压力"
        tp.font = UIFont.boldSystemFont(ofSize: 15)
        tp.frame = CGRect(x: 40, y: 200, width: 100, height: 50)
        return tp
    } ()
    
    lazy var lineView = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor(red: 89, green: 191, blue: 193)
        tp.layer.cornerRadius = 2
        tp.frame = CGRect(x: 32, y: 240, width: 48, height: 2)
        return tp
    } ()
    
    lazy var imageView = { () -> UIImageView in
        let tp = UIImageView(image: UIImage(named: "empty"))
        tp.contentMode = .scaleAspectFit
        tp.frame = CGRect(x: screenSize.width / 3 - 20, y: 280, width: screenSize.width / 3 + 40, height: screenSize.height / 3 + 40)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupUI()
        refreshBtns()
    }
    
    func setupUI() {
        let btnsBackgroundView = UIView()
        btnsBackgroundView.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        btnsBackgroundView.frame = CGRect(x: 15, y: 25+navHeight, width: btnWidth*5, height: 30)
        btnsBackgroundView.layer.cornerRadius = 5
    
        let datePickerBackgroundView = UIView()
        datePickerBackgroundView.backgroundColor = UIColor(red: 241, green: 240, blue: 246)
        datePickerBackgroundView.layer.cornerRadius = 7.5
        datePickerBackgroundView.frame = CGRect(x: (screenSize.width - 230) / 2, y: 70 + navHeight, width: 230, height: 15)
        
        let strCharView = UILabel()
        strCharView.text = "至"
        strCharView.font = UIFont.systemFont(ofSize: 10)
        strCharView.frame = CGRect(x: screenSize.width / 2 - 7.5, y: 70 + navHeight, width: 15, height: 15)
        
        self.view.addSubview(btnsBackgroundView)
        self.view.addSubview(datePickerBackgroundView)
        self.view.addSubview(strCharView)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(btn5)
        self.view.addSubview(time1Label)
        self.view.addSubview(time2Label)
        self.view.addSubview(datePicker1)
        self.view.addSubview(datePicker2)
        self.view.addSubview(currentLabel)
        self.view.addSubview(lineView)
        self.view.addSubview(imageView)
    }
    
    func refreshBtns() {
        btn1.isSelected = selectIndex == 0 ? true : false
        btn2.isSelected = selectIndex == 1 ? true : false
        btn3.isSelected = selectIndex == 2 ? true : false
        btn4.isSelected = selectIndex == 3 ? true : false
        btn5.isSelected = selectIndex == 4 ? true : false
        btn1.backgroundColor = selectIndex == 0 ? UIColor(red: 89, green: 191, blue: 193) : UIColor(red: 239, green: 242, blue: 252)
        btn2.backgroundColor = selectIndex == 1 ? UIColor(red: 89, green: 191, blue: 193) : UIColor(red: 239, green: 242, blue: 252)
        btn3.backgroundColor = selectIndex == 2 ? UIColor(red: 89, green: 191, blue: 193) : UIColor(red: 239, green: 242, blue: 252)
        btn4.backgroundColor = selectIndex == 3 ? UIColor(red: 89, green: 191, blue: 193) : UIColor(red: 239, green: 242, blue: 252)
        btn5.backgroundColor = selectIndex == 4 ? UIColor(red: 89, green: 191, blue: 193) : UIColor(red: 239, green: 242, blue: 252)
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
    
    @objc func btn1Clicked() {
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
    
    @objc func btn2Clicked() {
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
    
    @objc func btn3Clicked() {
        selectIndex = 2
        refreshBtns()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 24 * 60 * 60 * 3)
        let date2 = Date()
        let str1 = dateFormatter.string(from: date1)
        let str2 = dateFormatter.string(from: date2)
        time1Label.text = str1
        time2Label.text = str2
        datePicker1.date = date1
        datePicker2.date = date2
    }
    
    @objc func btn4Clicked() {
        selectIndex = 3
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
    
    @objc func btn5Clicked() {
        selectIndex = 4
        refreshBtns()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 24 * 60 * 60 * 30)
        let date2 = Date()
        let str1 = dateFormatter.string(from: date1)
        let str2 = dateFormatter.string(from: date2)
        time1Label.text = str1
        time2Label.text = str2
        datePicker1.date = date1
        datePicker2.date = date2
    }
    
}
