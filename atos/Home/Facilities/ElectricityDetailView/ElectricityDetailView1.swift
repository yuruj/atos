//
//  ElectricityDetailView1.swift
//  atos
//
//  Created by 余润杰 on 2021/4/22.
//

import UIKit
import AAInfographics
import Alamofire
import SwiftyJSON

class ElectricityDetailView1: UIView {
    
    var chartDatas: [ChartDataModel]!
    
    let padding: CGFloat = 15
    let regularCellHeight: CGFloat = 250
    let selectViewHeight: CGFloat = 50
    let view1Height: CGFloat = 340
    let view6Height: CGFloat = 280
    let selectBtnWidth: CGFloat = (screenSize.width - 20) / 3
    
    lazy var dataLabel1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "2587"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 112, green: 144, blue: 222)
        return tp
    } ()
    
    lazy var dataLabel2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "6.609"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 112, green: 144, blue: 222)
        return tp
    } ()
    
    lazy var dataLabel3 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "5.016"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 238, green: 151, blue: 55)
        return tp
    } ()
    
    lazy var dataLabel4 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "620.4"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 238, green: 151, blue: 55)
        return tp
    } ()
    
    lazy var dataLabel5 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "620.4"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 238, green: 151, blue: 55)
        return tp
    } ()
    
    lazy var dataLabel6 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 230, green: 152, blue: 151)
        return tp
    } ()
    
    lazy var dataLabel7 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 230, green: 152, blue: 151)
        return tp
    } ()
    
    lazy var dataLabel8 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 230, green: 152, blue: 151)
        return tp
    } ()
    
    lazy var timeLabel1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "04-03 10:30"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 10)
        tp.textColor = UIColor.lightGray
        return tp
    } ()
    
    lazy var timeLabel2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "04-03 10:39"
        tp.textAlignment = .left
        tp.font = UIFont.boldSystemFont(ofSize: 10)
        tp.textColor = UIColor.lightGray
        return tp
    } ()
    
    lazy var scrollView = { () -> UIScrollView in
        let tp = UIScrollView()
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        tp.delegate = self
        return tp
    } ()
    
    lazy var view1 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: view1Height)
        let titleLabel = UILabel()
        titleLabel.text = "概览"
        titleLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 40)
        let unitRectWidth: CGFloat = (screenSize.width - 40) / 2
        let rect1 = UIView()
        rect1.backgroundColor = UIColor(red: 234, green: 242, blue: 254)
        rect1.layer.cornerRadius = 5
        rect1.frame = CGRect(x: 15, y: 40, width: unitRectWidth, height: 70)
        let rect2 = UIView()
        rect2.backgroundColor = UIColor(red: 234, green: 242, blue: 254)
        rect2.layer.cornerRadius = 5
        rect2.frame = CGRect(x: 25 + unitRectWidth, y: 40, width: unitRectWidth, height: 70)
        let rect3 = UIView()
        rect3.backgroundColor = UIColor(red: 252, green: 240, blue: 224)
        rect3.layer.cornerRadius = 5
        rect3.frame = CGRect(x: 15, y: 120, width: unitRectWidth * 2 + 10, height: 100)
        let rect4 = UIView()
        rect4.backgroundColor = UIColor(red: 251, green: 237, blue: 240)
        rect4.layer.cornerRadius = 5
        rect4.frame = CGRect(x: 15, y: 230, width: unitRectWidth * 2 + 10, height: 100)
        let label1 = UILabel()
        label1.text = "昨日电量(kWh)"
        label1.font = UIFont.boldSystemFont(ofSize: 12)
        label1.frame = CGRect(x: 15, y: 10, width: 100, height: 20)
        rect1.addSubview(label1)
        dataLabel1.frame = CGRect(x: 15, y: 25, width: 100, height: 40)
        rect1.addSubview(dataLabel1)
        let label2 = UILabel()
        label2.text = "本月电量(万kWh)"
        label2.font = UIFont.boldSystemFont(ofSize: 12)
        label2.frame = CGRect(x: 15, y: 10, width: 100, height: 20)
        rect2.addSubview(label2)
        dataLabel2.frame = CGRect(x: 15, y: 25, width: 100, height: 40)
        rect2.addSubview(dataLabel2)
        let label3 = UILabel()
        label3.text = "当前负荷(kW)"
        label3.font = UIFont.boldSystemFont(ofSize: 12)
        label3.frame = CGRect(x: 15, y: 25, width: 100, height: 20)
        rect3.addSubview(label3)
        dataLabel3.frame = CGRect(x: 15, y: 40, width: 100, height: 40)
        rect3.addSubview(dataLabel3)
        let label4 = UILabel()
        label4.text = "本月最大负荷(kW)"
        label4.font = UIFont.systemFont(ofSize: 10)
        label4.frame = CGRect(x: 120, y: 10, width: 150, height: 20)
        rect3.addSubview(label4)
        dataLabel4.frame = CGRect(x: 120, y: 28, width: 100, height: 20)
        rect3.addSubview(dataLabel4)
        let label5 = UILabel()
        label5.text = "本月最大需量(kW)"
        label5.font = UIFont.systemFont(ofSize: 10)
        label5.frame = CGRect(x: 120, y: 50, width: 150, height: 20)
        rect3.addSubview(label5)
        dataLabel5.frame = CGRect(x: 120, y: 62, width: 100, height: 30)
        rect3.addSubview(dataLabel5)
        timeLabel1.frame = CGRect(x: 240, y: 10, width: 100, height: 20)
        timeLabel2.frame = CGRect(x: 240, y: 50, width: 100, height: 20)
        rect3.addSubview(timeLabel1)
        rect3.addSubview(timeLabel2)
        let label6 = UILabel()
        label6.text = "本月警告(次)"
        label6.font = UIFont.boldSystemFont(ofSize: 12)
        label6.frame = CGRect(x: 15, y: 25, width: 100, height: 20)
        rect4.addSubview(label6)
        dataLabel6.frame = CGRect(x: 15, y: 40, width: 100, height: 40)
        rect4.addSubview(dataLabel6)
        let label7 = UILabel()
        label7.text = "本月故障告警(次)"
        label7.font = UIFont.systemFont(ofSize: 10)
        label7.frame = CGRect(x: 120, y: 10, width: 150, height: 20)
        rect4.addSubview(label7)
        dataLabel7.frame = CGRect(x: 120, y: 28, width: 100, height: 20)
        rect4.addSubview(dataLabel7)
        let label8 = UILabel()
        label8.text = "本月重要告警(次)"
        label8.font = UIFont.systemFont(ofSize: 10)
        label8.frame = CGRect(x: 120, y: 50, width: 150, height: 20)
        rect4.addSubview(label8)
        dataLabel8.frame = CGRect(x: 120, y: 62, width: 100, height: 30)
        rect4.addSubview(dataLabel8)
        tp.addSubview(titleLabel)
        tp.addSubview(rect1)
        tp.addSubview(rect2)
        tp.addSubview(rect3)
        tp.addSubview(rect4)
        return tp
    } ()
    
    lazy var view2 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: view1Height + padding, width: screenSize.width, height: regularCellHeight)
        let label1 = UILabel()
        label1.text = "负荷曲线(今日+昨日)"
        label1.frame = CGRect(x: 15, y: 0, width: 200, height: 40)
        let label2 = UILabel()
        label2.text = "kW/kvar/kVA"
        label2.textAlignment = .right
        label2.frame = CGRect(x: screenSize.width - 120, y: 15, width: 100, height: 20)
        label2.font = UIFont.systemFont(ofSize: 10)
        tp.addSubview(label1)
        tp.addSubview(label2)
        return tp
    } ()
    
    lazy var view3 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: view1Height + regularCellHeight + padding * 2, width: screenSize.width, height: regularCellHeight)
        let label1 = UILabel()
        label1.text = "电流(今日+昨日)"
        label1.frame = CGRect(x: 15, y: 0, width: 200, height: 40)
        let label2 = UILabel()
        label2.text = "A"
        label2.textAlignment = .right
        label2.frame = CGRect(x: screenSize.width - 120, y: 15, width: 100, height: 20)
        label2.font = UIFont.systemFont(ofSize: 10)
        tp.addSubview(label1)
        tp.addSubview(label2)
        return tp
    } ()
    
    lazy var view4 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: view1Height + regularCellHeight * 2 + padding * 3, width: screenSize.width, height: regularCellHeight)
        let label1 = UILabel()
        label1.text = "线电压(今日+昨日)"
        label1.frame = CGRect(x: 15, y: 0, width: 200, height: 40)
        let label2 = UILabel()
        label2.text = "V"
        label2.textAlignment = .right
        label2.frame = CGRect(x: screenSize.width - 120, y: 15, width: 100, height: 20)
        label2.font = UIFont.systemFont(ofSize: 10)
        tp.addSubview(label1)
        tp.addSubview(label2)
        return tp
    } ()
    
    lazy var view5 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: view1Height + regularCellHeight * 3 + padding * 4, width: screenSize.width, height: regularCellHeight)
        let label1 = UILabel()
        label1.text = "电量+功率因数(今日+昨日)"
        label1.frame = CGRect(x: 15, y: 0, width: 300, height: 40)
        let label2 = UILabel()
        label2.text = "kWh"
        label2.textAlignment = .right
        label2.frame = CGRect(x: screenSize.width - 120, y: 15, width: 100, height: 20)
        label2.font = UIFont.systemFont(ofSize: 10)
        tp.addSubview(label1)
        tp.addSubview(label2)
        return tp
    } ()
    
    lazy var view6 = { () -> UIView in
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.frame = CGRect(x: 0, y: view1Height + regularCellHeight * 4 + padding * 5, width: screenSize.width, height: view6Height)
        let label1 = UILabel()
        label1.text = "告警（3日）"
        label1.font = UIFont.systemFont(ofSize: 18)
        label1.textAlignment = .left
        label1.frame = CGRect(x: 15, y: 0, width: 200, height: 50)
        tp.addSubview(label1)
        let label2 = UILabel()
        label2.text = "暂无数据"
        label2.font = UIFont.systemFont(ofSize: 13)
        label2.textAlignment = .center
        label2.frame = CGRect(x: 0, y: 50, width: screenSize.width, height: 50)
        tp.addSubview(label2)
        let image = UIImageView(image: UIImage(named: "noResult"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 0, y: 100, width: screenSize.width, height: view6Height - 100)
        tp.addSubview(image)
        return tp
    } ()
    
    lazy var chart1 = {  () -> AAChartView in
        let chartModel = AAChartModel()
            .chartType(.spline)
            .inverted(false)
            .yAxisVisible(false)
            .xAxisVisible(true)
            .legendEnabled(true)
            .markerRadius(0)
            .legendEnabled(false)
            .categories(chartDatas[0].categories)
            .colorsTheme(["#fe117c", "#ffc069", "#06caf4"])
            .series([
                AASeriesElement()
                    .name("有功")
                    .data(chartDatas[0].seriesData[0])
                    .toDic()!,
                AASeriesElement()
                    .name("无功")
                    .data(chartDatas[0].seriesData[1])
                    .toDic()!
            ])
        let tp = AAChartView()
        tp.frame = CGRect(x: 10, y: 45, width: screenSize.width - 20, height: 200)
        tp.aa_drawChartWithChartModel(chartModel)
        return tp
    } ()
    
    lazy var chart2 = {  () -> AAChartView in
        let chartModel = AAChartModel()
            .chartType(.spline)
            .inverted(false)
            .yAxisVisible(false)
            .xAxisVisible(true)
            .legendEnabled(true)
            .markerRadius(0)
            .legendEnabled(false)
            .categories(chartDatas[1].categories)
            .colorsTheme(["#fe117c", "#ffc069", "#06caf4"])
            .series([
                AASeriesElement()
                    .name("A")
                    .data(chartDatas[1].seriesData[0])
                    .toDic()!,
                AASeriesElement()
                    .name("B")
                    .data(chartDatas[1].seriesData[1])
                    .toDic()!,
                AASeriesElement()
                    .name("C")
                    .data(chartDatas[1].seriesData[2])
                    .toDic()!
            ])
        let tp = AAChartView()
        tp.frame = CGRect(x: 10, y: 45, width: screenSize.width - 20, height: 200)
        tp.aa_drawChartWithChartModel(chartModel)
        return tp
    } ()
    
    lazy var chart3 = {  () -> AAChartView in
        let chartModel = AAChartModel()
            .chartType(.spline)
            .inverted(false)
            .yAxisVisible(false)
            .xAxisVisible(true)
            .legendEnabled(true)
            .markerRadius(0)
            .legendEnabled(false)
            .categories(chartDatas[2].categories)
            .colorsTheme(["#fe117c", "#ffc069", "#06caf4"])
            .series([
                AASeriesElement()
                    .name("AB")
                    .data(chartDatas[2].seriesData[0])
                    .toDic()!,
                AASeriesElement()
                    .name("BC")
                    .data(chartDatas[2].seriesData[1])
                    .toDic()!,
                AASeriesElement()
                    .name("CA")
                    .data(chartDatas[2].seriesData[2])
                    .toDic()!
            ])
        let tp = AAChartView()
        tp.frame = CGRect(x: 10, y: 45, width: screenSize.width - 20, height: 200)
        tp.aa_drawChartWithChartModel(chartModel)
        return tp
    } ()
    
    lazy var chart4 = {  () -> AAChartView in
        let chartModel = AAChartModel()
            .chartType(.spline)
            .inverted(false)
            .yAxisVisible(false)
            .xAxisVisible(true)
            .legendEnabled(true)
            .markerRadius(0)
            .legendEnabled(false)
            .categories(chartDatas[3].categories)
            .colorsTheme(["#fe117c", "#ffc069", "#06caf4"])
            .series([
                AASeriesElement()
                    .name("功率因数")
                    .data(chartDatas[3].seriesData[0])
                    .toDic()!,
                AASeriesElement()
                    .name("谷")
                    .data(chartDatas[3].seriesData[1])
                    .toDic()!,
                AASeriesElement()
                    .name("平")
                    .data(chartDatas[3].seriesData[2])
                    .toDic()!,
                AASeriesElement()
                    .name("峰")
                    .data(chartDatas[3].seriesData[3])
                    .toDic()!,
                AASeriesElement()
                    .name("尖")
                    .data(chartDatas[3].seriesData[4])
                    .toDic()!
            ])
        let tp = AAChartView()
        tp.frame = CGRect(x: 10, y: 45, width: screenSize.width - 20, height: 200)
        tp.aa_drawChartWithChartModel(chartModel)
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.scrollView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - navHeight + selectViewHeight)
        self.scrollView.contentSize = CGSize(width: screenSize.width, height: padding * 5 + regularCellHeight * 4 + view1Height + view6Height)
        setupChartData()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(view1)
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(view3)
        self.scrollView.addSubview(view4)
        self.scrollView.addSubview(view5)
        self.scrollView.addSubview(view6)
        self.view2.addSubview(chart1)
        self.view3.addSubview(chart2)
        self.view4.addSubview(chart3)
        self.view5.addSubview(chart4)
    }
    
    func setupChartData() {
        let categories = [
            "00:00 04-19", "02:00 04-19", "04:00 04-19", "06:00 04-19",
            "08:00 04-19", "10:00 04-19", "12:00 04-19", "14:00 04-19",
            "16:00 04-19", "18:00 04-19", "20:00 04-19", "22:00 04-19",
            "00:00 04-20", "02:00 04-20", "04:00 04-20", "06:00 04-20",
            "08:00 04-20", "10:00 04-20", "12:00 04-20", "14:00 04-20",
            "16:00 04-20", "18:00 04-20", "20:00 04-20", "22:00 04-20"
        ]
        
        let seriesData1 = [[
            3.984, 17.544, 4.488, 5.784, 283.296, 333.408, 130.344, 302.544, 148.872, 84.792, 76.92, 7.536, 6,
            8.232, 7.608, 7.704, 129.984, 180.72, 128.928, 192.072, 203.808, 144.144, 103.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ]]
        let seriesData2 = [[
            3.984, 17.544, 4.488, 5.784, 283.296, 333.408, 130.344, 302.544, 148.872, 84.792, 76.92, 7.536, 6,
            8.232, 7.608, 7.704, 129.984, 180.72, 128.928, 192.072, 203.808, 144.144, 103.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ]]
        let seriesData3 = [[
            3.984, 17.544, 4.488, 5.784, 283.296, 333.408, 130.344, 302.544, 148.872, 84.792, 76.92, 7.536, 6,
            8.232, 7.608, 7.704, 129.984, 180.72, 128.928, 192.072, 203.808, 144.144, 103.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ]]
        let seriesData4 = [[
            3.984, 17.544, 4.488, 5.784, 283.296, 333.408, 130.344, 302.544, 148.872, 84.792, 76.92, 7.536, 6,
            8.232, 7.608, 7.704, 129.984, 180.72, 128.928, 192.072, 203.808, 144.144, 103.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ], [
            5.984, 19.544, 1.488, 15.784, 383.296, 303.408, 150.344, 278.544, 111.872, 100.792, 80.92, 9.536, 1,
            9.232, 10.608, 17.704, 149.984, 160.72, 148.928, 202.072, 233.808, 144.144, 133.224
        ]]
        chartDatas = []
        let singleModel1 = ChartDataModel(categories: categories, seriesData: seriesData1)
        let singleModel2 = ChartDataModel(categories: categories, seriesData: seriesData2)
        let singleModel3 = ChartDataModel(categories: categories, seriesData: seriesData3)
        let singleModel4 = ChartDataModel(categories: categories, seriesData: seriesData4)
        chartDatas.append(singleModel1)
        chartDatas.append(singleModel2)
        chartDatas.append(singleModel3)
        chartDatas.append(singleModel4)
    }
    
    func getDataOverview() {
        let urlStr = testURL + "/benergy/power/meter/" + "" + "/overview"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        
        AF.request(urlStr, method: .get, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
            
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getChart1Data() {
        
    }
    
    func getChart2Data() {
        
    }
    
    func getChart3Data() {
        
    }
    
    func getChart4Data() {
        
    }
    
}

extension ElectricityDetailView1: UIScrollViewDelegate {
    
}
