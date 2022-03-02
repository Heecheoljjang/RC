//
//  FinishViewController.swift
//  Thread를 이용한 게임
//
//  Created by HeecheolYoon on 2022/02/28.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var sellFishLabel: UILabel!
    @IBOutlet weak var restFishLabel: UILabel!
    @IBOutlet weak var failFishLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var tempSellLabel: Int = 0
    var tempRestLabel: Int = 0
    var tempFailureLabel: Int = 0
    
    var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sellFishLabel.text = String(tempSellLabel)
        restFishLabel.text = String(tempRestLabel)
        failFishLabel.text = String(tempFailureLabel)
        
        total = 1000 * tempSellLabel - 500 * tempRestLabel - 500 * tempFailureLabel
        
        totalPriceLabel.text = String(total)
        
    }
 

}
