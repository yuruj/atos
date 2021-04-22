//
//  FacilitiesDetailCollectionViewCell1.swift
//  atos
//
//  Created by 余润杰 on 2021/4/13.
//

import UIKit

class FacilitiesDetailCollectionViewCell1: UICollectionViewCell {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "一楼照明（总开关）"
        tp.font = UIFont.boldSystemFont(ofSize: 16)
        return tp
    } ()
    
    lazy var datalabel1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "4.488"
        tp.textAlignment = .right
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 112, green: 144, blue: 222)
        return tp
    } ()
    
    lazy var datalabel2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "----"
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
        icon1.frame = CGRect(x: 17, y: 15, width: 20, height: 20)
        icon1.contentMode = .scaleAspectFill
        let icon2 = UIView()
        icon2.layer.masksToBounds = true
        icon2.layer.cornerRadius = 5
        icon2.backgroundColor = UIColor(red: 107, green: 218, blue: 182)
        icon2.frame = CGRect(x: self.bounds.width - 25, y: 15, width: 10, height: 10)
        self.addSubview(icon1)
        self.addSubview(icon2)
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = "kW"
        label1.font = UIFont.systemFont(ofSize: 14)
        label1.frame = CGRect(x: self.bounds.width - 40, y: 46, width: 60, height: 25)
        label2.text = "A"
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.frame = CGRect(x: self.bounds.width - 40, y: 71, width: 60, height: 25)
        self.addSubview(label1)
        self.addSubview(label2)
        let label1_left = UILabel()
        let label2_left = UILabel()
        label1_left.text = "当前负荷"
        label1_left.font = UIFont.systemFont(ofSize: 12)
        label1_left.frame = CGRect(x: 41, y: 46, width: 60, height: 25)
        label2_left.text = "平均电流"
        label2_left.font = UIFont.systemFont(ofSize: 12)
        label2_left.frame = CGRect(x: 41, y: 71, width: 60, height: 25)
        self.addSubview(label1_left)
        self.addSubview(label2_left)
        let icon1_left = UIImageView(image: UIImage(named: "icon1_left"))
        icon1_left.contentMode = .scaleAspectFill
        icon1_left.frame = CGRect(x: 20, y: 51, width: 15, height: 15)
        let icon2_left = UIImageView(image: UIImage(named: "A-"))
        icon2_left.contentMode = .scaleAspectFill
        icon2_left.frame = CGRect(x: 20, y: 76, width: 15, height: 15)
        self.addSubview(icon1_left)
        self.addSubview(icon2_left)
        // dynamic
        titleLabel.frame = CGRect(x: 42, y: 0, width: 200, height: 50)
        datalabel1.frame = CGRect(x: self.bounds.width - 193, y: 46, width: 150, height: 25)
        datalabel2.frame = CGRect(x: self.bounds.width - 193, y: 71, width: 150, height: 25)
        self.addSubview(titleLabel)
        self.addSubview(datalabel1)
        self.addSubview(datalabel2)
    }
    
}
