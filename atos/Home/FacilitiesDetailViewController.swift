//
//  FacilitiesDetailViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/7.
//

import UIKit

enum FacilitiesType: String {
    case allPoint         = "全部采集点"
    case electricityMeter = "电表采集点"
    case waterMeter       = "水表采集点"
    case gasMeter         = "气表采集点"
    case sensor           = "传感器采集点"
}

class FacilitiesDeatilViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    var currentFacilitiesType: FacilitiesType = .allPoint
    
    lazy var collectionView = { () -> UICollectionView in
        let tp = UICollectionView()
        return tp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
