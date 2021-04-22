//
//  SearchViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class SearchViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var searchBar = { () -> UISearchBar in
        let tp = UISearchBar()
        tp.backgroundColor = UIColor.white
        tp.barStyle = UIBarStyle.default
        tp.barTintColor = UIColor.clear
        tp.placeholder = "请输入搜索关键词"
        tp.searchBarStyle = .minimal
        tp.showsCancelButton = false
        tp.showsBookmarkButton = false
        tp.delegate = self
        // 键盘类型设置
        tp.keyboardType = .emailAddress
        tp.returnKeyType = .search
        tp.isSecureTextEntry = false
        tp.layer.cornerRadius = 50
        tp.frame = CGRect(x: 10, y: 10, width: screenSize.width - 20, height: 50)
        tp.becomeFirstResponder()
        return tp
    } ()
    
    lazy var scrollView = { () -> UIScrollView in
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        let tp = UIScrollView()
        tp.backgroundColor = UIColor.white
        tp.refreshControl = refreshControl
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: screenSize.height)
        tp.delegate = self
        return tp
    } ()
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 40, height: 80)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView(frame: CGRect(x: 0, y: 60, width: screenSize.width, height: screenSize.height), collectionViewLayout: layout)
        tp.backgroundColor = nil
        tp.delegate = self
        tp.dataSource = self
        tp.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        tp.isScrollEnabled = false
        
        return tp
    } ()
    
    lazy var bottomView = { () -> UIView in
        let tp = UIView()
        let label = UILabel()
        label.text = "下面没有了，一共\(1)家用户"
        return tp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入search界面----")
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(searchBar)
//        self.scrollView.addSubview(collectionView)
    }
    
    @objc func refreshView() {
        NSLog("----下拉刷新----")
    }
    
}

extension SearchViewController: UISearchBarDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSLog("----搜索 \(searchText)----")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.refreshControl?.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeViewCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("----点击 \(indexPath.item) cell----")
    }
}
