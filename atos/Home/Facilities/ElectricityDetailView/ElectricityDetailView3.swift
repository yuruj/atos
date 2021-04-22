//
//  ElectricityDetailView3.swift
//  atos
//
//  Created by 余润杰 on 2021/4/22.
//

import UIKit
import Alamofire
import SwiftyJSON

enum Period: String {
    case time1 = "5分钟"
    case time2 = "15分钟"
    case time3 = "1小时"
    case time4 = "2小时"
}

class ElectricityDetailView3: UIView {
    
    var period: Period = .time1 {
        didSet {
            self.dataLabel.text = period.rawValue
        }
    }
    
    lazy var dataLabel = { () -> UILabel in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(changePeriod))
        let tp = UILabel()
        tp.text = period.rawValue
        tp.textColor = UIColor(red: 90, green: 100, blue: 130)
        tp.font = UIFont.systemFont(ofSize: 12)
        tp.textAlignment = .right
        tp.frame = CGRect(x: screenSize.width - 150, y: 30, width: 100, height: 50)
        tp.addGestureRecognizer(tapGes)
        tp.isUserInteractionEnabled = true
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        backgroundView.frame = CGRect(x: 0, y: 30, width: screenSize.width, height: 50)
        self.addSubview(backgroundView)
        let textLabel = UILabel()
        textLabel.text = "曲线配置"
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.textColor = UIColor(red: 90, green: 100, blue: 130)
        textLabel.textAlignment = .left
        textLabel.frame = CGRect(x: 15, y: 0, width: 100, height: 30)
        self.addSubview(textLabel)
        let label1 = UILabel()
        label1.text = "密度"
        label1.font = UIFont.boldSystemFont(ofSize: 15)
        label1.tintColor = UIColor.black
        label1.frame = CGRect(x: 15, y: 30, width: 100, height: 50)
        self.addSubview(label1)
        let image = UIImageView(image: UIImage(named: "arrowdown"))
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: screenSize.width - 50, y: 40, width: 30, height: 30)
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(changePeriod))
        image.addGestureRecognizer(tapGes)
        image.isUserInteractionEnabled = true
        self.addSubview(image)
        self.addSubview(dataLabel)
    }
    
    lazy var coverView = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        let tp = UIView()
        tp.backgroundColor = UIColor.gray
        tp.alpha = 0.8
        tp.frame = CGRect(x: 0, y: -50, width: screenSize.width, height: screenSize.height)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var BottomSelectBox = { () -> UIView in
        let frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        
        let tp = UIView()
        tp.frame = frame
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        
        let label1 = UILabel()
        label1.text = "5分钟"
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
        label2.text = "15分钟"
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
        label3.text = "1小时"
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
        label4.text = "2小时"
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
        label5.text = "取消"
        label5.textColor = UIColor.black
        label5.textAlignment = .center
        label5.frame = CGRect(x: 0, y: 250, width: screenSize.width, height: 60)
        label5.font = UIFont.systemFont(ofSize: 20)
        label5.backgroundColor = UIColor.white
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(bottomSelectBoxDismiss))
        label5.addGestureRecognizer(tapGes)
        label5.isUserInteractionEnabled = true
        tp.addSubview(label5)
        
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
        tp.addSubview(line1)
        tp.addSubview(line2)
        tp.addSubview(line3)
        tp.addSubview(line4)
        
        return tp
    } ()
    
    @objc func changePeriod() {
        self.addSubview(coverView)
        self.addSubview(BottomSelectBox)
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height - 360 - navHeight, width: screenSize.width, height: 310)
        })
    }
    
    @objc func label1Clicked() {
        period = .time1
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    @objc func label2Clicked() {
        period = .time2
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    @objc func label3Clicked() {
        period = .time3
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    @objc func label4Clicked() {
        period = .time4
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    @objc func bottomSelectBoxDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
}
