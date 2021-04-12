//
//  CompanyDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var scrollView = { () -> UIScrollView in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        let tp = UIScrollView()
        tp.backgroundColor = UIColor.gray
        tp.refreshControl = refreshControl
        tp.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tp.delegate = self
        return tp
    } ()
    
    lazy var view1 = { () -> UIView in
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 300)
        let roundingCorners = UIRectCorner(rawValue: (UIRectCorner.bottomLeft.rawValue) | (UIRectCorner.bottomRight.rawValue))
        let maskParh = UIBezierPath(roundedRect: frame, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: 10, height: 10))
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 20, y: 20, width: 100, height: 80)
        tp.addSubview(titleLabel)
        tp.frame = frame
        return tp
    } ()
    
    lazy var magicRect1 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: 30, y: 120, width: 100, height: 100))
        tp.backgroundColor = UIColor.green
        return tp
    } ()
    
    lazy var magicRect2 = { () -> UIView in
        let tp = MagicRectView(frame: CGRect(x: 150, y: 120, width: 100, height: 100))
        tp.backgroundColor = UIColor.green
        return tp
    } ()
    
    lazy var magicRect3 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect3Clicked))
        let tp = MagicRectView(frame: CGRect(x: 270, y: 120, width: 100, height: 100))
        tp.backgroundColor = UIColor.green
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "设施总览"
        tp.frame = CGRect(x: 20, y: 320, width: 100, height: 30)
        return tp
    } ()
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 40, height: 50)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: 20, y: 370, width: screenSize.width - 40, height: 80*3+20*2), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(CompanyDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        tp.isScrollEnabled = false
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(view1)
        self.scrollView.addSubview(magicRect1)
        self.scrollView.addSubview(magicRect2)
        self.scrollView.addSubview(magicRect3)
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(collectionView)
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func magicRect3Clicked() {
        NSLog("----magicRect3 Clicked----")
    }
}

extension CompanyDetailViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CompanyDetailCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("----点击 \(indexPath.item) cell----")
    }
    
}
