//
//  DatePickerViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/4.
//

import UIKit

class DataPickerViewController: UIViewController {
    override func viewDidLoad() {
        let datePicker = UIDatePicker()
        self.view.addSubview(datePicker)
        datePicker.backgroundColor = UIColor.lightGray
        datePicker.datePickerMode = .date
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = Date(timeInterval: -93312000, since: Date())
        datePicker.maximumDate = Date(timeIntervalSinceNow: 93312000)
//        datePicker.minuteInterval = 5
        datePicker.locale = Locale(identifier: "zh_CN")
//        datePicker.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        // 提取时间
        let _ = datePicker.date
    }
}
