//
//  ElectricityDetailDataModel.swift
//  atos
//
//  Created by 余润杰 on 2021/4/19.
//

import Foundation

struct ChartDataModel {
    
    var categories: [String]
    var seriesData: [[Double]]
    
    init(categories: [String], seriesData: [[Double]]) {
        self.categories = categories
        self.seriesData = seriesData
    }
    
}
