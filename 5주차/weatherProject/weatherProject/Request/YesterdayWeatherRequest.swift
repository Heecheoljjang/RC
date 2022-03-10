//
//  YesterdayWeatherRequest.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/10.
//

import Foundation
import UIKit
import Alamofire

class YesterdayWeatherRequest {
    
    func getYesterdayData(lat: Double, lon: Double, dt: Int, viewController: LoginViewController) {
        let url = "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=\(lat)&lon=\(lon)&dt=\(dt)&appid=4af5cb37399a98438645cb803764aa97"
        
        AF.request(url, method: .get).responseDecodable(of: YesterdayResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("success: \(response)")

                //viewController.tempWeatherResponse = response
                viewController.tempYesterdayResponse = response
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
