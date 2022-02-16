//
//  PayViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/16.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var timeRemaining: Int = 600
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIScreen.main.brightness = 1.0 //밝기 최고
        
        timeLabel.textColor = UIColor(named: "starbucksGreen")
        secondTimeLabel.textColor = UIColor(named: "starbucksGreen")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timeRemaining = 600
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    @objc func step() {
        var min: Int
        var sec: Int
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            timeRemaining = 600
        }
        min = timeRemaining / 60
        sec = timeRemaining % 60
        
        timeLabel.text = String(format: "%02d:%02d", min, sec)
        secondTimeLabel.text = String(format: "%02d:%02d", min, sec)
    }
}

