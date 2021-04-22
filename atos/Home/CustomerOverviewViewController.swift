//
//  CustomerOverviewViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit
import MBProgressHUD

enum CustomerType: String {
    case allCustomer              = "所有客户"
    case importantCustomer        = "重点客户"
    case newCustomer              = "新客户"
    case energyEfficiencyCustomer = "能效客户"
}

class CustomerOverviewViewController: UIViewController {
    
    var currentCustomerType: CustomerType = .allCustomer {
        didSet {
            self.view2.text = currentCustomerType.rawValue
        }
    }
    
    var searchLabelHeight: CGFloat!
    var view1Height: CGFloat!
    var view2Height: CGFloat!
    var cellHeight: CGFloat!
    
    func setupUIParameters() {
        searchLabelHeight = 50
        view1Height = 50
        view2Height = 60
        cellHeight = 80
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
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(searchViewClicked))
        let searchView = SearchLabelView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: searchLabelHeight))
        searchView.addGestureRecognizer(tapGes)
        searchView.backgroundColor = UIColor.clear
        searchView.label.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        tp.addSubview(searchView)
        tp.frame = frame
        return tp
    } ()

    lazy var view2 = { () -> UILabel in
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(currentCustomerBtnClicked))
        let tp = UILabel()
        tp.text = "所有客户"
        tp.addGestureRecognizer(tapGes)
        tp.isUserInteractionEnabled = true
        tp.frame = CGRect(x: 15, y: view1Height, width: screenSize.width, height: view2Height)
        tp.font = UIFont.boldSystemFont(ofSize: 16)
        tp.textAlignment = .left
        return tp
    } ()
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 20, height: cellHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: 10, y: view1Height + view2Height, width: screenSize.width - 20, height: cellHeight), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: "cell4")
        return tp
    } ()

    lazy var lineLabel = { () -> UILabel in
        let tp = UILabel()
        tp.text = "——————  下面没有了，一共3家客户  ——————"
        tp.textAlignment = .center
        tp.frame = CGRect(x: 0, y: view1Height + view2Height + cellHeight, width: screenSize.width, height: 50)
        tp.textColor = UIColor.lightGray
        tp.font = UIFont.systemFont(ofSize: 12)
        return tp
    } ()
    
    lazy var BottomSelectBox = { () -> UIView in
        let frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        
        let tp = UIView()
        tp.frame = frame
        tp.backgroundColor = UIColor(red: 239, green: 242, blue: 252)
        
        let label1 = UILabel()
        label1.text = "所有客户"
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
        label2.text = "重点客户"
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
        label3.text = "新客户"
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
        label4.text = "能效客户"
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
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(collectionView)
        self.scrollView.addSubview(lineLabel)
        let arrowImage = UIImageView(image: UIImage(named: "arrowdown"))
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.frame = CGRect(x: 85, y: view1Height + 13, width: view2Height / 2, height: view2Height / 2)
        self.scrollView.addSubview(arrowImage)
    }
    
    func reGenerateView() {
        NSLog("重新生成页面")
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
    @objc func searchViewClicked() {
        NSLog("----searchView Clicked----")
        let vc = SearchViewController()
        vc.title = "企业搜索"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func currentCustomerBtnClicked() {
        NSLog("----选择客户类型----")
        self.view.addSubview(coverView)
        self.view.addSubview(BottomSelectBox)
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height - 310, width: screenSize.width, height: 310)
        })
    }
    
    @objc func label1Clicked() {
        currentCustomerType = .allCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label2Clicked() {
        currentCustomerType = .importantCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label3Clicked() {
        currentCustomerType = .newCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func label4Clicked() {
        currentCustomerType = .energyEfficiencyCustomer
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
        reGenerateView()
    }
    
    @objc func bottomSelectBoxDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.BottomSelectBox.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 310)
        })
        coverView.removeFromSuperview()
        BottomSelectBox.removeFromSuperview()
    }
    
    func showHud() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.label.text = "该企业暂时未提供能效服务"
        hud.label.font = UIFont.systemFont(ofSize: 13)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.black
        hud.bezelView.alpha = 0.8
        hud.label.textColor = UIColor.white
        hud.hide(animated: true, afterDelay: 2)
    }
}


extension CustomerOverviewViewController: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! HomeViewCollectionViewCell
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
