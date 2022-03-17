//
//  AddressRequest.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/08.
//

import Foundation
import UIKit
import Alamofire

class AddressRequest {
    
    func getAddressData(lat: Double, long: Double, viewcontroller: LoginViewController) {
        
        let url = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=\(long)&y=\(lat)"
        
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK b46d4ecf15e232f27476375dd4bcc2d6" ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: AddressResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("success: \(response)")
                //viewcontroller.setLocationLabel(response)
                viewcontroller.tempAddressResponse = response
            case .failure(let error):
                print("error: \(error)")
                
            }
        }

    }
}
