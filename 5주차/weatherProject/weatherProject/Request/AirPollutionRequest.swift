//
//  AirPollutionRequest.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/09.

import Foundation
import UIKit
import Alamofire

class AirPollutionRequest {
    
    func getAirPollutionData(lat: Double, long: Double, viewcontroller: LoginViewController) {
        
        let url = "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=\(lat)&lon=\(long)&appid=4af5cb37399a98438645cb803764aa97"
                
        AF.request(url, method: .get).responseDecodable(of: AirPollutionResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("success: \(response)")
                viewcontroller.tempAirPollutionResponse = response
                //코드 작성

            case .failure(let error):
                print("error: \(error)")
                
            }
        }
    }
}
