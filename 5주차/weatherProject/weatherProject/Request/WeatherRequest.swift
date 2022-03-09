//
//  weatherRequest.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/08.
//

import Foundation
import UIKit
import Alamofire

class WeatherRequest {
    func getWeatherData(lat: Double, lon: Double, viewController: MainViewController) {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=4af5cb37399a98438645cb803764aa97"
        
        AF.request(url, method: .get).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("success: \(response)")
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
