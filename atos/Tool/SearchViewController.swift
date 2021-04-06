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
        tp.backgroundColor = UIColor.lightGray
        tp.barStyle = UIBarStyle.default
        tp.barTintColor = UIColor.clear
        tp.placeholder = "请输入搜索关键词"
        tp.searchBarStyle = .minimal
        tp.showsCancelButton = true
        tp.showsBookmarkButton = true
        tp.delegate = self
        // 键盘类型设置
        tp.keyboardType = .emailAddress
        tp.returnKeyType = .search
        tp.isSecureTextEntry = false
        tp.layer.cornerRadius = 10
        tp.frame = CGRect(x: 10, y: 100, width: screenSize.width - 20, height: 50)
        tp.becomeFirstResponder()
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("----进入search界面----")
        self.view.addSubview(searchBar)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSLog("----搜索 \(searchText)----")
    }
}
