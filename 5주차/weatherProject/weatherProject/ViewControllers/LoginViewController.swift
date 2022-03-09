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
        
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()

    }
    
    @IBAction func tapKakao(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                guard let vc = sb.instantiateViewController(withIdentifier: "main") as? MainViewController else { return }
//
//                vc.modalPresentationStyle = .fullScreen
//
//                vc.tempLat = self.tempLat
//                vc.tempLong = self.tempLong
//
//                self.present(vc, animated: true, completion: nil)
                let space = self.locationManager.location?.coordinate
                guard let tempLat = space?.latitude else { return }
                guard let tempLong = space?.longitude else { return }
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "main") as? MainViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.tempLong = tempLong
                vc.tempLat = tempLat
                
                self.present(vc, animated: true, completion: nil)

            }
        }
    }

}
