//
//  HomeViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/3/20.
//

import UIKit

class HomeViewController: UIViewController {

    var searchLabelHeight: CGFloat!
    var magicRectBorderLength: CGFloat!
    var magicRectX: (CGFloat, CGFloat, CGFloat)!
    var view1Height: CGFloat!
    var view2Height: CGFloat!
    var padding: CGFloat!
    var cellHeight: CGFloat!
    
    func setupUIParameters() {
        magicRectBorderLength = 100
        searchLabelHeight = 50
        view1Height = 230
        view2Height = 60
        padding = (screenSize.width - magicRectBorderLength * 3) / 4
        magicRectX = (padding, padding * 2 + magicRectBorderLength, padding * 3 + magicRectBorderLength * 2)
        cellHeight = 80
    }
    
    lazy var data1Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "3"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.0+magicRectBorderLength/2-11, y: view1Height-magicRectBorderLength+26, width: 50, height: 50)
        return tp
    } ()
    
    lazy var data2Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "1"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.1+magicRectBorderLength/2-11, y: view1Height-magicRectBorderLength+26, width: 50, height: 50)
        return tp
    } ()
    
    lazy var data3Label = { () -> UILabel in
        let tp = UILabel()
        tp.text = "0"
        tp.font = UIFont.boldSystemFont(ofSize: 22)
        tp.textColor = UIColor(red: 242, green: 187, blue: 65)
        tp.frame = CGRect(x: magicRectX.2+magicRectBorderLength/2-11, y: view1Height-magicRectBorderLength+26, width: 50, height: 50)
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
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(searchViewClicked))
        let searchView = SearchLabelView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: searchLabelHeight))
        searchView.addGestureRecognizer(tapGes)
        searchView.backgroundColor = UIColor.white
        searchView.label.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        let titleLabel = UILabel()
        titleLabel.text = "客户概览"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .left
        titleLabel.frame = CGRect(x: padding, y: searchLabelHeight, width: screenSize.width, height: view1Height - magicRectBorderLength - 15 - searchLabelHeight)
        tp.addSubview(titleLabel)
        tp.addSubview(searchView)
        tp.frame = frame
        return tp
    } ()
    
    lazy var magicRect1 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect1Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var magicRect2 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect2Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var magicRect3 = { () -> UIView in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(magicRect3Clicked))
        let tp = MagicRectView(frame: CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength - 15, width: magicRectBorderLength, height: magicRectBorderLength))
        tp.backgroundColor = UIColor(red: 249, green: 245, blue: 235)
        tp.addGestureRecognizer(tapGes)
        return tp
    } ()
    
    lazy var view2 = { () -> UILabel in
        let tp = UILabel()
        tp.text = "能效客户 1家"
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
        tp.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: "cell1")
        return tp
    } ()
    
    lazy var lineLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "——————  下面没有了，一共1家客户  ——————"
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
        label1.text = "所有客户"
        label1.font = UIFont.systemFont(ofSize: 12)
        label1.textAlignment = .center
        label1.textColor = UIColor(red: 90, green: 100, blue: 130)
        label1.frame = CGRect(x: magicRectX.0, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        let label2 = UILabel()
        label2.text = "重点客户"
        label2.font = UIFont.systemFont(ofSize: 12)
        label2.textAlignment = .center
        label2.textColor = UIColor(red: 90, green: 100, blue: 130)
        label2.frame = CGRect(x: magicRectX.1, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        let label3 = UILabel()
        label3.text = "7日新客户"
        label3.font = UIFont.systemFont(ofSize: 12)
        label3.textAlignment = .center
        label3.textColor = UIColor(red: 90, green: 100, blue: 130)
        label3.frame = CGRect(x: magicRectX.2, y: view1Height-magicRectBorderLength-5, width: magicRectBorderLength, height: 30)
        let label11 = UILabel()
        label11.text = "家"
        label11.textColor = UIColor(red: 242, green: 187, blue: 65)
        label11.font = UIFont.systemFont(ofSize: 10)
        label11.frame = CGRect(x: magicRectX.0+magicRectBorderLength/2+8, y: view1Height-magicRectBorderLength+40, width: 30, height: 30)
        let label22 = UILabel()
        label22.text = "家"
        label22.textColor = UIColor(red: 242, green: 187, blue: 65)
        label22.font = UIFont.systemFont(ofSize: 10)
        label22.frame = CGRect(x: magicRectX.1+magicRectBorderLength/2+8, y: view1Height-magicRectBorderLength+40, width: 30, height: 30)
        let label33 = UILabel()
        label33.text = "家"
        label33.textColor = UIColor(red: 242, green: 187, blue: 65)
        label33.font = UIFont.systemFont(ofSize: 10)
        label33.frame = CGRect(x: magicRectX.2+magicRectBorderLength/2+8, y: view1Height-magicRectBorderLength+40, width: 30, height: 30)
        self.scrollView.addSubview(label1)
        self.scrollView.addSubview(label2)
        self.scrollView.addSubview(label3)
        self.scrollView.addSubview(label11)
        self.scrollView.addSubview(label22)
        self.scrollView.addSubview(label33)
        self.scrollView.addSubview(data1Label)
        self.scrollView.addSubview(data2Label)
        self.scrollView.addSubview(data3Label)
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func magicRect1Clicked() {
        NSLog("----magicRect1 Clicked----")
        let vc = CustomerOverviewViewController()
        vc.title = "客户总览"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func magicRect2Clicked() {
        NSLog("----magicRect2 Clicked----")
        let vc = CustomerOverviewViewController()
        vc.title = "客户总览"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func magicRect3Clicked() {
        NSLog("----magicRect3 Clicked----")
        let vc = CustomerOverviewViewController()
        vc.title = "客户总览"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchViewClicked() {
        NSLog("----searchView Clicked----")
        let vc = SearchViewController()
        vc.title = "企业搜索"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! HomeViewCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("----点击 \(indexPath.item) cell----")
        let vc = CompanyDetailViewController()
        vc.title = "重庆名都科技有限公司"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
