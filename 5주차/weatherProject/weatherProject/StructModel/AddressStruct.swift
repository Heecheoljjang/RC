//
//  AddressStruct.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/08.
//

import Foundation
import UIKit

struct AddressResponse: Codable {
    
    var meta: Meta
    var documents: [Document]
    
}

struct Meta: Codable {
    
    var total_count: Int
    
}

struct Document: Codable {
    
    var region_type: String
    var address_name: String
    //var region_1depth_name: String
    var region_2depth_name: String
    var region_3depth_name: String
    //var region_4depth_name: String
    //var code: String
    var x: Double
    var y: Double
    
}
