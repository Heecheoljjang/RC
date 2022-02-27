//
//  ViewController.swift
//  Thread를 이용한 게임
//
//  Created by HeecheolYoon on 2022/02/26.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var beforeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    @IBAction func pushBtn(_ sender: Any) {
        if beforeImg.image == UIImage(named: "before") {
            beforeImg.image = UIImage(named: "1")
        } else {
            beforeImg.image = UIImage(named: "before")
        }
    }
    

}

