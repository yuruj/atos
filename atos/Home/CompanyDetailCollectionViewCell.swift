//
//  CompanyDetailCollectionViewCell.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class CompanyDetailCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "自动化生产楼"
        tp.font = UIFont.boldSystemFont(ofSize: 18)
        return tp
    } ()
    
    lazy var datalabel1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "2.232"
        tp.textAlignment = .right
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 112, green: 144, blue: 222)
        return tp
    } ()
    
    lazy var datalabel2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "712.8"
        tp.textAlignment = .right
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 89, green: 191, blue: 193)
        return tp
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // static
        let icon1 = UIImageView(image: UIImage(named: "icon1"))
        let icon2 = UIImageView(image: UIImage(named: "icon2"))
        let icon3 = UIImageView(image: UIImage(named: "icon3"))
        let icon4 = UIImageView(image: UIImage(named: "icon4"))
        let icon1x = self.bounds.width - 120
        icon1.frame = CGRect(x: icon1x, y: 15, width: 20, height: 20)
        icon1.contentMode = .scaleAspectFill
        icon2.frame = CGRect(x: icon1x + 30, y: 15, width: 20, height: 20)
        icon2.contentMode = .scaleAspectFill
        icon3.frame = CGRect(x: icon1x + 60, y: 15, width: 20, height: 20)
        icon3.contentMode = .scaleAspectFill
        icon4.frame = CGRect(x: icon1x + 90, y: 15, width: 20, height: 20)
        icon4.contentMode = .scaleAspectFill
        self.addSubview(icon1)
        self.addSubview(icon2)
        self.addSubview(icon3)
        self.addSubview(icon4)
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = "万kWh"
        label1.font = UIFont.systemFont(ofSize: 14)
        label1.frame = CGRect(x: icon1x + 60, y: 45, width: 60, height: 25)
        label2.text = "kW"
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.frame = CGRect(x: icon1x + 60, y: 70, width: 60, height: 25)
        self.addSubview(label1)
        self.addSubview(label2)
        let label1_left = UILabel()
        let label2_left = UILabel()
        label1_left.text = "昨日电量"
        label1_left.font = UIFont.systemFont(ofSize: 10)
        label1_left.frame = CGRect(x: 41, y: 45, width: 60, height: 25)
        label1_left.textColor = UIColor(red: 90, green: 100, blue: 130)
        label2_left.text = "当前负荷"
        label2_left.font = UIFont.systemFont(ofSize: 10)
        label2_left.frame = CGRect(x: 41, y: 70, width: 60, height: 25)
        label2_left.textColor = UIColor(red: 90, green: 100, blue: 130)
        self.addSubview(label1_left)
        self.addSubview(label2_left)
        let icon1_left = UIImageView(image: UIImage(named: "icon1_left"))
        icon1_left.contentMode = .scaleAspectFill
        icon1_left.frame = CGRect(x: 20, y: 48, width: 15, height: 15)
        let icon2_left = UIImageView(image: UIImage(named: "icon2_left"))
        icon2_left.contentMode = .scaleAspectFill
        icon2_left.frame = CGRect(x: 20, y: 73, width: 15, height: 15)
        self.addSubview(icon1_left)
        self.addSubview(icon2_left)
        // dynamic
        titleLabel.frame = CGRect(x: 20, y: 0, width: 200, height: 50)
        datalabel1.frame = CGRect(x: icon1x - 93, y: 45, width: 150, height: 25)
        datalabel2.frame = CGRect(x: icon1x - 93, y: 70, width: 150, height: 25)
        self.addSubview(titleLabel)
        self.addSubview(datalabel1)
        self.addSubview(datalabel2)
    }

    
}
