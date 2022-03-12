//
//  ViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/05.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate{
        
    //var locationManager: CLLocationManager!
    var locationManager = CLLocationManager()
    
    var tempLat: Double?
    var tempLong: Double?
    
    var tempWeatherResponse: WeatherResponse?
    var tempAddressResponse: AddressResponse?
    var tempYesterdayResponse: YesterdayResponse?
    var tempAirPollutionResponse: AirPollutionResponse?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        // 거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
        // 위치 사용을 허용하면 현재 위치 정보를 가져옴
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
        }
        else {
            print("위치 서비스 허용 off")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            tempLat = location.coordinate.latitude
            tempLong = location.coordinate.longitude
            
            print("위치 업데이트!")
            print("위도 : \(tempLat!)")
            print("경도 : \(tempLong!)")
        }
    }


    @IBAction func tapKakao(_ sender: Any) {
        
        guard let lat = tempLat else { return }
        guard let long = tempLong else { return }
        
        WeatherRequest().getWeatherData(lat: lat, lon: long, viewController: self)

        AddressRequest().getAddressData(lat: lat, long: long, viewcontroller: self)
        
        AirPollutionRequest().getAirPollutionData(lat: lat, long: long, viewcontroller: self)

        let dt = Date().timeIntervalSince1970 - 86400
        print(dt)
        YesterdayWeatherRequest().getYesterdayData(lat: lat, lon: long, dt: Int(dt), viewController: self)
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                          
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "main") as? MainViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.tempWeatherResponse = self.tempWeatherResponse
                vc.tempAddressResponse = self.tempAddressResponse
                vc.tempYesterdayResponse = self.tempYesterdayResponse
                vc.tempAirPollutionResponse = self.tempAirPollutionResponse
                
                vc.tempLat = lat
                vc.tempLong = long
                
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

}
