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
        
    var tempLat: Double?
    var tempLong: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
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
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "main") as? MainViewController else { return }
                
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

