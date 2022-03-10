//
//  WeatherStruct.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/08.
//

import Foundation
import UIKit
import Alamofire

struct WeatherResponse: Codable {
    
    //var lat: Double
    //var lon: Double
    //var timezone: String
    //var timezone_offset: Int
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
    
}

struct Current: Codable {
    
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Double
    var feels_like: Double
    //var pressure: Int
    var humidity: Int
    //var dew_point: Double
    var uvi: Double
    //var clouds: Int
    //var visibility: Int
    var wind_speed: Double
    //var wind_deg: Int
    var weather: [Weather]
}

struct Weather: Codable {
    
    var id: Int
    var main: String
    //var description: String
    //var icon: String
    
}

struct Hourly: Codable {
    
    var dt: Int
    var temp: Double
    var feels_like: Double
    //var pressure: Int
    var humidity: Int
    //var dew_point: Double
    var uvi: Double
    //var clouds: Int
    //var visibility: Int
    var wind_speed: Double
    //var wind_deg: Int
    //var wind_gust: Double
    var weather: [Weather]
    //var pop: Double
    
}

struct Daily: Codable {
    
    var dt: Int
    var sunrise: Int
    var sunset: Int
    //var moonrise: Int
    //var moonset: Int
    var moon_phase: Double
    var temp: Temp
    var feels_like: FeelsLike
    //var pressure: Int
    var humidity: Int
    //var dew_point: Double
    var wind_speed: Double
    //var wind_deg: Int
    //var wind_gust: Double
    var weather: [Weather]
    //var clouds: Int
    //var pop: Double
    //var rain: Double
    var uvi: Double
    
}

struct Temp: Codable {
    
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
    
}

struct FeelsLike: Codable {
    
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
    
}
