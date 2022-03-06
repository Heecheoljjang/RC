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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    
    var tempLat: Double?
    var tempLong: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    @IBAction func tapKakaoLoginBtn(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
            }
        }
    }
    
}

