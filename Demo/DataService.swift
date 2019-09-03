//
//  DataService.swift
//  Demo
//
//  Created by Manek Bindi on 03/09/19.
//  Copyright © 2019 Bindi Manek. All rights reserved.
//

import Foundation
import Alamofire

class DataService {
    
    static let dataService = DataService()

    
    func getData(page:String,completionHandler: @escaping([TitleData]) -> ()) {
        if CommonFunctions.shared.isInternetAvailable() {
            var titleDataList = [TitleData]()

            let urlComponent = URLComponents(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)")!
            
            print("urlComponent \(urlComponent)")
            var request = URLRequest(url: urlComponent.url!)
            request.httpMethod = "GET"
            Alamofire.request(request).responseJSON { response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                guard let response1 = response.value as? NSDictionary else {
                    return
                }
                let result = response1["hits"] as! NSArray
                print("result \(result)")
                for i in 0 ..< result.count {
                    let responseTemp:NSDictionary = result.object(at: i) as! NSDictionary
                    print("responseTemp \(responseTemp)")
                    let tempData = TitleData.init(Title: responseTemp.value(forKey: "title") as! String, CreatedAt: responseTemp.value(forKey: "created_at") as! String)
                        titleDataList.append(tempData)
                }
                completionHandler(titleDataList)
            }
        } else {
            CommonFunctions.shared.showAlert(withMessage: "No Internet Connection")
        }
    }
    
}
