//
//  HomVewCollectionViewCell.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class HomeViewCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "重庆名都科技有限公司"
        tp.font = UIFont.boldSystemFont(ofSize: 15)
        tp.frame = CGRect(x: 15, y: 0, width: 200, height: 40)
        return tp
    } ()
    
    lazy var label1 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "-"
        tp.frame = CGRect(x: 32, y: 50, width: 15, height: 15)
        tp.textColor = UIColor(red: 90, green: 100, blue: 130)
        return tp
    } ()
    
    lazy var label2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "-"
        tp.frame = CGRect(x: screenSize.width / 2 + 17, y: 50, width: 15, height: 15)
        tp.textColor = UIColor(red: 90, green: 100, blue: 130)
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
        let icon1 = UIImageView(image: UIImage(named: "people_small"))
        icon1.frame = CGRect(x: 15, y: 50, width: 15, height: 15)
        icon1.contentMode = .scaleAspectFill
        let icon2 = UIImageView(image: UIImage(named: "phone_small"))
        icon2.frame = CGRect(x: screenSize.width / 2, y: 50, width: 15, height: 15)
        icon2.contentMode = .scaleAspectFill
        self.addSubview(icon1)
        self.addSubview(icon2)
        self.addSubview(titleLabel)
        self.addSubview(label1)
        self.addSubview(label2)
    }
    
}
