//
//  FacilitiesDetailCollectionViewCell4.swift
//  atos
//
//  Created by 余润杰 on 2021/4/20.
//

import UIKit

class FacilitiesDetailCollectionViewCell4: UICollectionViewCell {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "消防水水压"
        tp.font = UIFont.boldSystemFont(ofSize: 16)
        return tp
    } ()
    
    lazy var dataLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0.046"
        tp.textAlignment = .right
        tp.font = UIFont.boldSystemFont(ofSize: 14)
        tp.textColor = UIColor(red: 112, green: 144, blue: 222)
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
        let icon1 = UIImageView(image: UIImage(named: "icon4")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        icon1.tintColor = UIColor(red: 112, green: 215, blue: 219)
        icon1.frame = CGRect(x: 17, y: 15, width: 20, height: 20)
        icon1.contentMode = .scaleAspectFill
        let icon2 = UIView()
        icon2.layer.masksToBounds = true
        icon2.layer.cornerRadius = 5
        icon2.backgroundColor = UIColor(red: 238, green: 151, blue: 55)
        icon2.frame = CGRect(x: self.bounds.width - 25, y: 15, width: 10, height: 10)
        self.addSubview(icon1)
        self.addSubview(icon2)
        let label_right = UILabel()
        label_right .text = "MPa"
        label_right.font = UIFont.systemFont(ofSize: 13)
        label_right.frame = CGRect(x: self.bounds.width - 40, y: 46, width: 60, height: 25)
        self.addSubview(label_right)
        let label_left = UILabel()
        label_left.text = "当前压力"
        label_left.font = UIFont.systemFont(ofSize: 12)
        label_left.frame = CGRect(x: 41, y: 46, width: 60, height: 25)
        self.addSubview(label_left)
        let icon_left = UIImageView(image: UIImage(named: "pressureicon"))
        icon_left.contentMode = .scaleAspectFill
        icon_left.frame = CGRect(x: 20, y: 51, width: 15, height: 15)
        self.addSubview(icon_left)
        // dynamic
        titleLabel.frame = CGRect(x: 42, y: 0, width: 200, height: 50)
        dataLabel.frame = CGRect(x: self.bounds.width - 193, y: 46, width: 150, height: 25)
        self.addSubview(titleLabel)
        self.addSubview(dataLabel)
    }
    
}
