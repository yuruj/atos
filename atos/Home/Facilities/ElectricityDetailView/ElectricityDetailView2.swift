//
//  ElectricityDetailView2.swift
//  atos
//
//  Created by 余润杰 on 2021/4/22.
//

import UIKit
import AAInfographics
import Alamofire
import SwiftyJSON

enum ElectricityMeterDataType: String {
    case power          = "power"
    case current        = "current"
    case voltage        = "voltage"
    case wiresVoltage   = "voltage/wires"
    case activePower    = "power/active"
    case reactivePower  = "power/reactive"
    case factorPower    = "power/fatcor"
    case energy         = "energy"
    case activeEnergy   = "energy/active"
    case reactiveEnergy = "energy/reactive"
    case voltageAngle   = "voltage/angle"
    case currentAngle   = "current/angle"
}

class ElectricityDetailView2: UIView {
    
    var chartDatas: ChartDataModel!
    
    var period: String = "pt15m"  // 时间间隔
    
    var selectIndex: Int = 0
    var selectIndexs: Int = 0
    
    var magicRectBorderLength: CGFloat!
    var magicRectX: (CGFloat, CGFloat, CGFloat)!
    var padding: CGFloat!
    
    func setupUIParameters() {
        magicRectBorderLength = 100
        padding = (screenSize.width - magicRectBorderLength * 3) / 4
        magicRectX = (padding, padding * 2 + magicRectBorderLength, padding * 3 + magicRectBorderLength * 2)
    }
    
    lazy var magicRect1 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: magicRectX.0, y: 60, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        return tp
    } ()
    
    lazy var magicRect2 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: magicRectX.1, y: 60, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        return tp
    } ()
    
    lazy var magicRect3 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: magicRectX.2, y: 60, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        return tp
    } ()
    
    lazy var data1Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "1334"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.0, y: 92, width: magicRectBorderLength, height: 50)
        return tp
    } ()
    
    lazy var data2Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0.941"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.1, y: 92, width: magicRectBorderLength, height: 50)
        return tp
    } ()
    
    lazy var data3Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "228.2"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.2, y: 92, width: magicRectBorderLength, height: 50)
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
    
    lazy var chartView = {  () -> AAChartView in
        let tp = AAChartView()
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUIParameters()
        setupUI()
        refreshBtns()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(time1Label)
        self.addSubview(time2Label)
        self.addSubview(todayBtn)
        self.addSubview(yesterdayBtn)
        self.addSubview(recentBtn)
        self.addSubview(datePicker1)
        self.addSubview(datePicker2)
        self.addSubview(magicRect1)
        self.addSubview(magicRect2)
        self.addSubview(magicRect3)
        
        let charView = UILabel()
        charView.text = "~"
        charView.textAlignment = .center
        charView.frame = CGRect(x: 70, y: 5, width: 50, height: 50)
        self.addSubview(charView)
        
        let label1 = UILabel()
        label1.text = "昨日电量 kWh"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textAlignment = .center
        label1.textColor = UIColor(red: 90, green: 100, blue: 130)
        label1.frame = CGRect(x: magicRectX.0, y: 60, width: magicRectBorderLength, height: 30)
        let label2 = UILabel()
        label2.text = "功率因数"
        label2.font = UIFont.systemFont(ofSize: 12)
        label2.textAlignment = .center
        label2.textColor = UIColor(red: 90, green: 100, blue: 130)
        label2.frame = CGRect(x: magicRectX.1, y: 60, width: magicRectBorderLength, height: 30)
        let label3 = UILabel()
        label3.text = "昨日最大需量 kW"
        label3.font = UIFont.systemFont(ofSize: 12)
        label3.textAlignment = .center
        label3.textColor = UIColor(red: 90, green: 100, blue: 130)
        label3.frame = CGRect(x: magicRectX.2, y: 60, width: magicRectBorderLength, height: 30)
        
        
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        self.addSubview(data1Label)
        self.addSubview(data2Label)
        self.addSubview(data3Label)
        
        self.addSubview(scrollView)
        self.scrollView.addSubview(btn1)
        self.scrollView.addSubview(btn2)
        self.scrollView.addSubview(btn3)
        self.scrollView.addSubview(btn4)
        self.scrollView.addSubview(btn5)
        self.scrollView.addSubview(btn6)
        self.scrollView.addSubview(btn7)
        self.scrollView.addSubview(btn8)
        self.scrollView.addSubview(btn9)
        self.scrollView.addSubview(btn10)
        self.scrollView.addSubview(btn11)
        self.scrollView.addSubview(btn12)
        self.scrollView.addSubview(btnLine)
        
        refreshBtnss()
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
        self.addSubview(datePicker1)
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
        self.addSubview(datePicker2)
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
    
    func getYesterdayPower() {
        let urlStr = testURL + "/eff/widget"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        let par: Parameters = [
            "metric": "r.ep.pos",
            "key": "id",
            "aggr": "diff",
            "nodeId": "",
            "nodelevel": "powerMeter",
            "state": "",
            "end": ""
        ]
        
        AF.request(urlStr, method: .get, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getPowerFactor() {
        let urlStr = testURL + "/tsdb/widget"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        let par: Parameters = [
            "kets": [
                [
                    "aggr": "mean",
                    "key": "powerfactor",
                    "metric": "e.pf"
                ]
            ],
            "nodeId": "",
            "nodelevel": "powerMeter",
            "state": "",
            "end": ""
        ]
        
        AF.request(urlStr, method: .post, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getYesterdayMaximumVoltage() {
        let urlStr = testURL + "/tsdb/widget"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        let par: Parameters = [
            "kets": [
                [
                    "aggr": "max",
                    "key": "maxdemand",
                    "metric": "e.pf"
                ]
            ],
            "nodeId": "",
            "nodelevel": "powerMeter",
            "state": "",
            "end": ""
        ]
        
        AF.request(urlStr, method: .post, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getElectricityMeterData(type: ElectricityMeterDataType) {
        let urlStr = testURL + "/tsdb/elec/chart/" + type.rawValue
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        let par: Parameters = [
            "nodeId": "",
            "nodelevel": "powerMeter",
            "state": "",
            "end": "",
            "period": period
        ]
        
        AF.request(urlStr, method: .get, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
    lazy var scrollView = { () -> UIScrollView in
        let tp = UIScrollView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 10, y: 200, width: screenSize.width - 20, height: 60)
        tp.contentSize = CGSize(width: btnWidth*12, height: 60)
        tp.showsHorizontalScrollIndicator = false
        return tp
    } ()
    
    let btnWidth = 60
    let btnHeight = 30
    
    lazy var btn1 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("总功率", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn2 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("电流", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn3 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("相电压", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 2, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn4 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("线电压", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 3, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn5 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("有功功率", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 4, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn6 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("无功功率", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 5, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn7 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("功率因数", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 6, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn8 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("电量", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 7, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn9 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("有功电量", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 8, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn10 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("无功电量", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 9, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn11 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("电压相角", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 10, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btn12 = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("电流相角", for: .normal)
        tp.setTitleColor(UIColor.black, for: .selected)
        tp.setTitleColor(UIColor.lightGray, for: .normal)
        tp.frame = CGRect(x: btnWidth * 11, y: 0, width: btnWidth, height: btnHeight)
        return tp
    } ()
    
    lazy var btnLine = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor(red: 89, green: 189, blue: 191)
        tp.frame = CGRect(x: 25, y: 40, width: 50, height: 2)
        return tp
    } ()
    
    func refreshBtnss() {
        btn1.isSelected = selectIndexs == 0 ? true : false
        btn2.isSelected = selectIndexs == 1 ? true : false
        btn3.isSelected = selectIndexs == 2 ? true : false
        btn4.isSelected = selectIndexs == 3 ? true : false
        btn5.isSelected = selectIndexs == 4 ? true : false
        btn6.isSelected = selectIndexs == 5 ? true : false
        btn7.isSelected = selectIndexs == 6 ? true : false
        btn8.isSelected = selectIndexs == 7 ? true : false
        btn9.isSelected = selectIndexs == 8 ? true : false
        btn10.isSelected = selectIndexs == 9 ? true : false
        btn11.isSelected = selectIndexs == 10 ? true : false
        btn12.isSelected = selectIndexs == 11 ? true : false
//        moveLine()
    }
    
    func moveLine() {
        let x = selectIndexs * btnWidth + 10
        UIView.animate(withDuration: 0.3) {
            self.btnLine.frame = CGRect(x: x, y: 40, width: 50, height: 2)
        }
    }
    
    @objc func btn1Clicked() {
        selectIndexs = 0
        refreshBtnss()
    }
    
    @objc func btn2Clicked() {
        selectIndexs = 1
        refreshBtnss()
    }
    
    @objc func btn3Clicked() {
        selectIndexs = 2
        refreshBtnss()
    }
    
    @objc func btn4Clicked() {
        selectIndexs = 3
        refreshBtnss()
    }
    
    @objc func btn5Clicked() {
        selectIndexs = 4
        refreshBtnss()
    }
    
    @objc func btn6Clicked() {
        selectIndexs = 5
        refreshBtnss()
    }
    
    @objc func btn7Clicked() {
        selectIndexs = 6
        refreshBtnss()
    }
    
    @objc func btn8Clicked() {
        selectIndexs = 7
        refreshBtnss()
    }
    
    @objc func btn9Clicked() {
        selectIndexs = 8
        refreshBtnss()
    }
    
    @objc func btn10Clicked() {
        selectIndexs = 9
        refreshBtnss()
    }
    
    @objc func btn11Clicked() {
        selectIndexs = 10
        refreshBtnss()
    }
    
    @objc func btn12Clicked() {
        selectIndexs = 11
        refreshBtnss()
    }
    
}
