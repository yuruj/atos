//
//  CompanyDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit
import Alamofire
import SwiftyJSON

class CompanyDetailViewController: UIViewController {
    
    var magicRectBorderLength: CGFloat!
    var magicRectX: (CGFloat, CGFloat, CGFloat)!
    var view1Height: CGFloat!
    var view2Height: CGFloat!
    var padding: CGFloat!
    var cellHeight: CGFloat!
    
    func setupUIParameters() {
        magicRectBorderLength = 100
        view1Height = 180
        view2Height = 60
        padding = (screenSize.width - magicRectBorderLength * 3) / 4
        magicRectX = (padding, padding * 2 + magicRectBorderLength, padding * 3 + magicRectBorderLength * 2)
        cellHeight = 100
    }
    
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
    
    lazy var view1 = { () -> UIView in
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: view1Height)
        let roundingCorners = UIRectCorner(rawValue: (UIRectCorner.bottomLeft.rawValue) | (UIRectCorner.bottomRight.rawValue))
        let maskParh = UIBezierPath(roundedRect: frame, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        maskLayer.path = maskParh.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        
        let tp = UIView()
        tp.backgroundColor = UIColor.white
        tp.layer.mask = maskLayer
        let titleLabel = UILabel()
        titleLabel.text = "数据监控"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.frame = CGRect(x: padding, y: 0, width: screenSize.width, height: view1Height - magicRectBorderLength - 15)
        tp.addSubview(titleLabel)
        tp.frame = frame
        return tp
    } ()
    
    lazy var magicRect1 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
        return tp
    } ()
    
    lazy var magicRect2 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
        return tp
    } ()
    
    lazy var magicRect3 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect3Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var dataLabel1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "2.232"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 144, green: 220, blue: 221)
        tp.frame = CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength+26, width: magicRectBorderLength, height: 50)
        return tp
    } ()
    
    lazy var dataLabel2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "712.8"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 144, green: 220, blue: 221)
        tp.frame = CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength+26, width: magicRectBorderLength, height: 50)
        return tp
    } ()
    
    lazy var dataLabel3 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textAlignment = .center
        tp.textColor = UIColor(red: 144, green: 220, blue: 221)
        tp.frame = CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength+26, width: magicRectBorderLength, height: 50)
        return tp
    } ()
    
    lazy var view2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "设施总览"
        tp.frame = CGRect(x: padding - 5, y: view1Height, width: screenSize.width, height: view2Height)
        tp.font = UIFont.boldSystemFont(ofSize: 16)
        tp.textAlignment = .left
        return tp
    } ()
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 2 * padding + 10, height: cellHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: padding - 5, y: view1Height + view2Height, width: screenSize.width - 2 * padding + 10, height: cellHeight), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(CompanyDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        return tp
    } ()
    
    lazy var lineLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "——————  我是有底线的  ——————"
        tp.textAlignment = .center
        tp.frame = CGRect(x: 0, y: view1Height + view2Height + cellHeight, width: screenSize.width, height: 50)
        tp.textColor = UIColor.lightGray
        tp.font = UIFont.systemFont(ofSize: 12)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIParameters()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(view1)
        self.scrollView.addSubview(magicRect1)
        self.scrollView.addSubview(magicRect2)
        self.scrollView.addSubview(magicRect3)
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(collectionView)
        self.scrollView.addSubview(lineLabel)
        let label1 = UILabel()
        label1.text = "昨日电量(万kWh)"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textAlignment = .center
        label1.textColor = UIColor(red: 90, green: 100, blue: 130)
        label1.frame = CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        let label2 = UILabel()
        label2.text = "当前负荷(kW)"
        label2.font = UIFont.systemFont(ofSize: 12)
        label2.textAlignment = .center
        label2.textColor = UIColor(red: 90, green: 100, blue: 130)
        label2.frame = CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        let label3 = UILabel()
        label3.text = "今日告警(条)"
        label3.font = UIFont.systemFont(ofSize: 12)
        label3.textAlignment = .center
        label3.textColor = UIColor(red: 90, green: 100, blue: 130)
        label3.frame = CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        self.scrollView.addSubview(label1)
        self.scrollView.addSubview(label2)
        self.scrollView.addSubview(label3)
        self.scrollView.addSubview(dataLabel1)
        self.scrollView.addSubview(dataLabel2)
        self.scrollView.addSubview(dataLabel3)
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func magicRect3Clicked() {
        NSLog("----magicRect3 Clicked----")
        let vc = WarnDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getDataMonitoringStatistics() {
        let urlStr = testURL + "/benergy/customer/metric"
        let head: HTTPHeaders = ["Authorization": "bearer " + token]
        let par: Parameters = ["customerId": ""]
        
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
    
    func getListOfCorporateFacilities() {
        let urlStr = testURL + "/benergy/customer/facilities/metric"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        let par: Parameters = [
            "customerId": "",
            "page": 0,
            "size": 10
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
    
}

extension CompanyDetailViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CompanyDetailCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("----点击 \(indexPath.item) cell----")
        let vc = FacilitiesDeatilViewController()
        vc.title = "设施详情"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
