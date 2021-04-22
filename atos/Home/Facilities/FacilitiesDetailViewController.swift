//
//  FacilitiesDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/7.
//

import UIKit
import Alamofire
import SwiftyJSON

enum FacilitiesType: String {
    case allPoint         = "全部采集点"
    case electricityMeter = "电表采集点"
    case waterMeter       = "水表采集点"
    case gasMeter         = "气表采集点"
    case sensor           = "传感器采集点"
}

class FacilitiesDeatilViewController: UIViewController {
    
    var currentFacilitiesType: FacilitiesType = .allPoint {
        didSet {
            self.view2.text = currentFacilitiesType.rawValue
        }
    }
    
    let borderLength: CGFloat = 22
    
    var magicRectBorderLength: CGFloat!
    var magicRectX: (CGFloat, CGFloat, CGFloat, CGFloat)!
    var view1Height: CGFloat!
    var view2Height: CGFloat!
    var padding: CGFloat!
    var cellHeight1: CGFloat!
    var cellHeight4: CGFloat!
    
    func setupUIParameters() {
        magicRectBorderLength = 70
        view1Height = 110
        view2Height = 60
        padding = (screenSize.width - magicRectBorderLength * 4) / 5
        magicRectX = (padding, padding * 2 + magicRectBorderLength, padding * 3 + magicRectBorderLength * 2, padding * 4 + magicRectBorderLength * 3)
        cellHeight1 = 100
        cellHeight4 = 80
    }
    
    lazy var data1Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "3"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor.black
        tp.frame = CGRect(x: magicRectX.0 + (magicRectBorderLength - borderLength) / 2 + 3.5, y: view1Height-magicRectBorderLength + 23, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var data2Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor.black
        tp.frame = CGRect(x: magicRectX.1 + (magicRectBorderLength - borderLength) / 2 + 3.5, y: view1Height-magicRectBorderLength + 23, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var data3Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor.black
        tp.frame = CGRect(x: magicRectX.2 + (magicRectBorderLength - borderLength) / 2 + 3.5, y: view1Height-magicRectBorderLength + 23, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var data4Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "2"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor.black
        tp.frame = CGRect(x: magicRectX.3 + (magicRectBorderLength - borderLength) / 2 + 3.5, y: view1Height-magicRectBorderLength + 23, width: borderLength, height: borderLength)
        return tp
    } ()
    
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
        tp.frame = frame
        return tp
    } ()
    
    lazy var magicRect1 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect1Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var magicRect2 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect2Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 241, green: 244, blue: 254)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var magicRect3 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect3Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 252, green: 243, blue: 243)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var magicRect4 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect4Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.3, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var icon1View = { () -> UIImageView in
        let borderLength: CGFloat = 22
        let tp = UIImageView(image: UIImage(named: "icon1")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        tp.contentMode = .scaleAspectFill
        tp.tintColor = UIColor(red: 112, green: 215, blue: 219)
        tp.frame = CGRect(x: magicRectX.0 + (magicRectBorderLength - borderLength) / 2, y: view1Height-magicRectBorderLength - 5, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var icon2View = { () -> UIImageView in
        let borderLength: CGFloat = 22
        let tp = UIImageView(image: UIImage(named: "icon2")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        tp.contentMode = .scaleAspectFill
        tp.tintColor = UIColor(red: 176, green: 202, blue: 250)
        tp.frame = CGRect(x: magicRectX.1 + (magicRectBorderLength - borderLength) / 2, y: view1Height-magicRectBorderLength - 5, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var icon3View = { () -> UIImageView in
        let borderLength: CGFloat = 22
        let tp = UIImageView(image: UIImage(named: "icon3")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        tp.contentMode = .scaleAspectFill
        tp.tintColor = UIColor(red: 242, green: 164, blue: 167)
        tp.frame = CGRect(x: magicRectX.2 + (magicRectBorderLength - borderLength) / 2, y: view1Height-magicRectBorderLength - 5, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var icon4View = { () -> UIImageView in
        let borderLength: CGFloat = 22
        let tp = UIImageView(image: UIImage(named: "icon4")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        tp.contentMode = .scaleAspectFill
        tp.tintColor = UIColor(red: 202, green: 211, blue: 230)
        tp.frame = CGRect(x: magicRectX.3 + (magicRectBorderLength - borderLength) / 2, y: view1Height-magicRectBorderLength - 5, width: borderLength, height: borderLength)
        return tp
    } ()
    
    lazy var view2 = { () -> UILabel in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(currentPointBtnClicked))
        let tp = UILabel()
        tp.text = "全部采集点"
        tp.addGestureRecognizer(tapGes)
        tp.isUserInteractionEnabled = true
        tp.frame = CGRect(x: padding - 5, y: view1Height, width: screenSize.width, height: view2Height)
        tp.font = UIFont.boldSystemFont(ofSize: 16)
        tp.textAlignment = .left
        return tp
    } ()
    
    lazy var collectionView1 = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 2 * padding + 10, height: cellHeight1)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: padding - 5, y: view1Height + view2Height, width: screenSize.width - 2 * padding + 10, height: cellHeight1), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(FacilitiesDetailCollectionViewCell1.self, forCellWithReuseIdentifier: "cell3")
        tp.tag = 1
        return tp
    } ()
    
    lazy var collectionView4 = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 2 * padding + 10, height: cellHeight4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: padding - 5, y: view1Height + view2Height + cellHeight1 + padding, width: screenSize.width - 2 * padding + 10, height: cellHeight4), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(FacilitiesDetailCollectionViewCell4.self, forCellWithReuseIdentifier: "cell5")
        tp.tag = 4
        return tp
    } ()
    
    lazy var lineLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "——————  我是有底线的  ——————"
        tp.textAlignment = .center
        tp.frame = CGRect(x: 0, y: view1Height + view2Height + 180 + padding, width: screenSize.width, height: 50)
        tp.textColor = UIColor.lightGray
        tp.font = UIFont.systemFont(ofSize: 12)
        return tp
    } ()
    
    lazy var BottomSelectBox = { () -> UIView in
        let frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        
        let tp = UIView()
        tp.frame = frame
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        
        let label1 = UILabel()
        label1.text = "全部采集点"
        label1.textColor = UIColor(red: 144, green: 220, blue: 221)
        label1.textAlignment = .center
        label1.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 60)
        label1.font = UIFont.systemFont(ofSize: 20)
        label1.backgroundColor = UIColor.white
        let tapGes1 = UITapGestureRecognizer()
        tapGes1.addTarget(self, action: #selector(label1Clicked))
        label1.addGestureRecognizer(tapGes1)
        label1.isUserInteractionEnabled = true
        tp.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "电表采集点"
        label2.textColor = UIColor(red: 144, green: 220, blue: 221)
        label2.textAlignment = .center
        label2.frame = CGRect(x: 0, y: 60, width: screenSize.width, height: 60)
        label2.font = UIFont.systemFont(ofSize: 20)
        label2.backgroundColor = UIColor.white
        let tapGes2 = UITapGestureRecognizer()
        tapGes2.addTarget(self, action: #selector(label2Clicked))
        label2.addGestureRecognizer(tapGes2)
        label2.isUserInteractionEnabled = true
        tp.addSubview(label2)
        
        let label3 = UILabel()
        label3.text = "水表采集点"
        label3.textColor = UIColor(red: 144, green: 220, blue: 221)
        label3.textAlignment = .center
        label3.frame = CGRect(x: 0, y: 120, width: screenSize.width, height: 60)
        label3.font = UIFont.systemFont(ofSize: 20)
        label3.backgroundColor = UIColor.white
        let tapGes3 = UITapGestureRecognizer()
        tapGes3.addTarget(self, action: #selector(label3Clicked))
        label3.addGestureRecognizer(tapGes3)
        label3.isUserInteractionEnabled = true
        tp.addSubview(label3)
        
        let label4 = UILabel()
        label4.text = "气表采集点"
        label4.textColor = UIColor(red: 144, green: 220, blue: 221)
        label4.textAlignment = .center
        label4.frame = CGRect(x: 0, y: 180, width: screenSize.width, height: 60)
        label4.font = UIFont.systemFont(ofSize: 20)
        label4.backgroundColor = UIColor.white
        let tapGes4 = UITapGestureRecognizer()
        tapGes4.addTarget(self, action: #selector(label4Clicked))
        label4.addGestureRecognizer(tapGes4)
        label4.isUserInteractionEnabled = true
        tp.addSubview(label4)
        
        let label5 = UILabel()
        label5.text = "气表采集点"
        label5.textColor = UIColor(red: 144, green: 220, blue: 221)
        label5.textAlignment = .center
        label5.frame = CGRect(x: 0, y: 240, width: screenSize.width, height: 60)
        label5.font = UIFont.systemFont(ofSize: 20)
        label5.backgroundColor = UIColor.white
        let tapGes5 = UITapGestureRecognizer()
        tapGes5.addTarget(self, action: #selector(label5Clicked))
        label5.addGestureRecognizer(tapGes5)
        label5.isUserInteractionEnabled = true
        tp.addSubview(label5)
        
        let label6 = UILabel()
        label6.text = "取消"
        label6.textColor = UIColor.black
        label6.textAlignment = .center
        label6.frame = CGRect(x: 0, y: 310, width: screenSize.width, height: 60)
        label6.font = UIFont.systemFont(ofSize: 20)
        label6.backgroundColor = UIColor.white
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        label6.addGestureRecognizer(tapGes)
        label6.isUserInteractionEnabled = true
        tp.addSubview(label6)
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.lightGray
        line1.frame = CGRect(x: 0, y: 59.5, width: screenSize.width, height: 1)
        let line2 = UIView()
        line2.backgroundColor = UIColor.lightGray
        line2.frame = CGRect(x: 0, y: 59.5 + 60, width: screenSize.width, height: 1)
        let line3 = UIView()
        line3.backgroundColor = UIColor.lightGray
        line3.frame = CGRect(x: 0, y: 59.5 + 120, width: screenSize.width, height: 1)
        let line4 = UIView()
        line4.backgroundColor = UIColor.lightGray
        line4.frame = CGRect(x: 0, y: 59.5 + 180, width: screenSize.width, height: 1)
        let line5 = UIView()
        line5.backgroundColor = UIColor.lightGray
        line5.frame = CGRect(x: 0, y: 59.5 + 240, width: screenSize.width, height: 1)
        tp.addSubview(line1)
        tp.addSubview(line2)
        tp.addSubview(line3)
        tp.addSubview(line4)
        tp.addSubview(line5)
        
        return tp
    } ()
    
    lazy var coverView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        let tp = UIView()
        tp.backgroundColor = UIColor.gray
        tp.alpha = 0.8
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tp.addGestureRecognizer(tapGes)
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
        self.scrollView.addSubview(magicRect4)
        self.scrollView.addSubview(icon1View)
        self.scrollView.addSubview(icon2View)
        self.scrollView.addSubview(icon3View)
        self.scrollView.addSubview(icon4View)
        self.scrollView.addSubview(data1Label)
        self.scrollView.addSubview(data2Label)
        self.scrollView.addSubview(data3Label)
        self.scrollView.addSubview(data4Label)
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(collectionView1)
        self.scrollView.addSubview(collectionView4)
        self.scrollView.addSubview(lineLabel)
        let arrowImage = UIImageView(image: UIImage(named: "arrowdown"))
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.frame = CGRect(x: 115, y: view1Height + 13, width: view2Height / 2, height: view2Height / 2)
        self.scrollView.addSubview(arrowImage)
    }
    
    func reGenerateView() {
        NSLog("----重新生成页面----")
        switch currentFacilitiesType {
        case .allPoint:
            magicRect1.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
            magicRect2.backgroundColor = UIColor(red: 241, green: 244, blue: 254)
            magicRect3.backgroundColor = UIColor(red: 252, green: 243, blue: 243)
            magicRect4.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
            icon1View.tintColor = UIColor(red: 112, green: 215, blue: 219)
            icon2View.tintColor = UIColor(red: 176, green: 202, blue: 250)
            icon3View.tintColor = UIColor(red: 242, green: 164, blue: 167)
            icon4View.tintColor = UIColor(red: 202, green: 211, blue: 230)
        case .electricityMeter:
            magicRect1.backgroundColor = UIColor(red: 112, green: 215, blue: 219)
            magicRect2.backgroundColor = UIColor(red: 241, green: 244, blue: 254)
            magicRect3.backgroundColor = UIColor(red: 252, green: 243, blue: 243)
            magicRect4.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
            icon1View.tintColor = UIColor.white
            icon2View.tintColor = UIColor(red: 176, green: 202, blue: 250)
            icon3View.tintColor = UIColor(red: 242, green: 164, blue: 167)
            icon4View.tintColor = UIColor(red: 202, green: 211, blue: 230)
        case .waterMeter:
            magicRect1.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
            magicRect2.backgroundColor = UIColor(red: 176, green: 202, blue: 250)
            magicRect3.backgroundColor = UIColor(red: 252, green: 243, blue: 243)
            magicRect4.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
            icon1View.tintColor = UIColor(red: 112, green: 215, blue: 219)
            icon2View.tintColor = UIColor.white
            icon3View.tintColor = UIColor(red: 242, green: 164, blue: 167)
            icon4View.tintColor = UIColor(red: 202, green: 211, blue: 230)
        case .gasMeter:
            magicRect1.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
            magicRect2.backgroundColor = UIColor(red: 241, green: 244, blue: 254)
            magicRect3.backgroundColor = UIColor(red: 242, green: 164, blue: 167)
            magicRect4.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
            icon1View.tintColor = UIColor(red: 112, green: 215, blue: 219)
            icon2View.tintColor = UIColor(red: 176, green: 202, blue: 250)
            icon3View.tintColor = UIColor.white
            icon4View.tintColor = UIColor(red: 202, green: 211, blue: 230)
        case .sensor:
            magicRect1.backgroundColor = UIColor(red: 236, green: 250, blue: 250)
            magicRect2.backgroundColor = UIColor(red: 241, green: 244, blue: 254)
            magicRect3.backgroundColor = UIColor(red: 252, green: 243, blue: 243)
            magicRect4.backgroundColor = UIColor(red: 202, green: 211, blue: 230)
            icon1View.tintColor = UIColor(red: 112, green: 215, blue: 219)
            icon2View.tintColor = UIColor(red: 176, green: 202, blue: 250)
            icon3View.tintColor = UIColor(red: 242, green: 164, blue: 167)
            icon4View.tintColor = UIColor.white
        }
            
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func currentPointBtnClicked() {
        self.view.addSubview(coverView)
        self.view.addSubview(BottomSelectBox)
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height - 370, width: screenSize.width, height: 370)
        })
    }
    
    @objc func magicRect1Clicked() {
        if currentFacilitiesType == .electricityMeter {
            currentFacilitiesType = .allPoint
        } else {
            currentFacilitiesType = .electricityMeter
        }
        reGenerateView()
    }
    
    @objc func magicRect2Clicked() {
        if currentFacilitiesType == .waterMeter {
            currentFacilitiesType = .allPoint
        } else {
            currentFacilitiesType = .waterMeter
        }
        reGenerateView()
    }
    
    @objc func magicRect3Clicked() {
        if currentFacilitiesType == .gasMeter {
            currentFacilitiesType = .allPoint
        } else {
            currentFacilitiesType = .gasMeter
        }
        reGenerateView()
    }
    
    @objc func magicRect4Clicked() {
        if currentFacilitiesType == .sensor {
            currentFacilitiesType = .allPoint
        } else {
            currentFacilitiesType = .sensor
        }
        reGenerateView()
    }
    
    @objc func label1Clicked() {
        currentFacilitiesType = .allPoint
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label2Clicked() {
        currentFacilitiesType = .electricityMeter
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label3Clicked() {
        currentFacilitiesType = .waterMeter
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label4Clicked() {
        currentFacilitiesType = .gasMeter
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label5Clicked() {
        currentFacilitiesType = .sensor
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func bottomSelectBoxDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 370)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    func getListOfCollectionPoints(type: FacilitiesType, completionHandler: @escaping () -> ()) {
        let urlStr = testURL + "/benergy/facility/subdevice/metric/live"
        let head: HTTPHeaders = ["Authorization": "bearer" + token]
        var par: Parameters = [:]
        par = [
            "nodeId": "",
            "page": 0,
            "size": 10
        ]
        switch type {
        case .allPoint:
            break
        case .electricityMeter:
            par["type"] = "powerMeter"
        case .gasMeter:
            par["type"] = "wateMeter"
        case .sensor:
            par["type"] = "gasMeter"
        case .waterMeter:
            par["type"] = "sensor"
        }
        
        AF.request(urlStr, method: .get, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let _ = JSON.init(json)
                // 更新UI
                completionHandler()
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


extension FacilitiesDeatilViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 4 {
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 4 {
            let cell = self.collectionView4.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! FacilitiesDetailCollectionViewCell4
            return cell
        }
        let cell = self.collectionView1.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! FacilitiesDetailCollectionViewCell1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 4 {
            let vc = SensorDetailViewController()
            vc.title = ""
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        let vc = ElectricityDetailViewController()
        vc.title = ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
