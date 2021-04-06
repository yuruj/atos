//
//  CompanyDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/6.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenSize.width - 40, height: 50)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        let tp = UICollectionView()
        tp.backgroundColor = nil
//        tp.delegate = self
//        tp.dataSource = self
        tp.register(CompanyDetailCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CompanyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
