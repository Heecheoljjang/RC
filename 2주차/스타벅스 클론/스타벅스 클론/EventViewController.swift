//
//  EventViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/14.
//

import UIKit

class EventViewController: UIViewController {

    var hasBeenDisplayed: Bool = false
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var left: UIView!
    @IBOutlet weak var right: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        left.layer.cornerRadius = left.frame.height / 2
        right.layer.cornerRadius = left.frame.height / 2
        
        left.layer.borderWidth = 1
        left.layer.borderColor = UIColor.systemGray5.cgColor

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
