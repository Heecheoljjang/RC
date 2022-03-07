//
//  DataModel.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/06.
//

import Foundation
import UIKit

struct Response: Decodable {
    var data: [Datas]
    var meta: Meta
}
struct Datas: Decodable {
    var astronomicalDawn: String
    var astronomicalDusk: String
    var civilDawn: String
    var civilDusk: String
    var moonFraction: Double
    var moonPhase: MoonPhase
    var moonrise: String
    var moonset: String
    var nauticalDawn: String
    var nauticalDusk: String
    var sunrise: String
    var sunset: String
    var time: String
}
struct MoonPhase: Decodable {
    var closest: Closest
    var current: Current
}
struct Meta: Decodable {
    var cost: Int
    var dailyQuota: Int
    var lat: Double
    var lng: Double
    var requestCount: Int
    var start: String
}

struct Closest: Decodable {
    var text: String
    var time: String
    var value: Double
}

struct Current: Decodable {
    var text: String
    var time: String
    var value: Double
}
