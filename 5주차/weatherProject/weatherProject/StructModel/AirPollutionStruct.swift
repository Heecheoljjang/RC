//
//  AirPollutionStruct.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/09.
//
import Foundation
import UIKit
import Alamofire

struct AirPollutionResponse: Codable {

    var list: [List]
    
}

struct List: Codable {

    var main: Main
    var components: Components
    var dt: Int
}

struct Main: Codable {
    
    var aqi: Int

}

struct Components: Codable {
    
    var co: Double
    //var no: Double
    var no2: Double
    var o3: Double
    var so2: Double
    var pm2_5: Double
    var pm10: Double
    //var nh3: Double
    
}
