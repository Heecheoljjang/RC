//
//  HomeViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/15.
//

import UIKit

class HomeViewController: UIViewController {

    var hasBeenDisplayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "event") as? EventViewController else { return }
        
        vc.modalPresentationStyle = .fullScreen
        if hasBeenDisplayed == false {
            self.present(vc, animated: true, completion: nil)
            hasBeenDisplayed = true
        }
    }
    
}
