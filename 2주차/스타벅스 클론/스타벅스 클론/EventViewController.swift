//
//  EventViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/14.
//

import UIKit

class EventViewController: UIViewController {

    var hasBeenDisplayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func never(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        hasBeenDisplayed = true
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        hasBeenDisplayed = true
    }
}
