//
//  NetWorkSession.swift
//  atos
//
//  Created by 余润杰 on 2021/4/12.
//

import Alamofire
import SwiftyJSON

class NetWorkSession {
    
    private static var instance = NetWorkSession()
    
    class var shared: NetWorkSession { return instance }
    
    let testURL = "http://dev.voltmao.com:16080"
    let URL = "https://api.voltmao.com"
    
    var token = ""
    
    init () {
        
    }

    func login(account: String, password: String, successHandler: @escaping ()->(), failHandler: @escaping ()->()) {
        let urlStr = testURL + ""
        let head = constructLoginHead()
        var par = Parameters()
        par = [
            "username": "",
            "password": "",
            "grant_type": "",
            "scope": ""
        ]
        AF.request(urlStr, method: .get, parameters: par, headers: head).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                let jsonObj = JSON.init(json)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
}

extension NetWorkSession {
    
    private func constructLoginHead() -> HTTPHeaders {
        var head = HTTPHeaders()
        head = ["Authorization": "Basic Y2xpZW50OnNlY3JldA=="]
        return head
    }

    private func constructHead() -> HTTPHeaders {
        var head = HTTPHeaders()
        head = ["Authorization": "Bearer " + token]
        return head
    }
    
}
