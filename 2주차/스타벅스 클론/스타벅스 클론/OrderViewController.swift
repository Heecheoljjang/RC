//
//  OrderViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/13.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! SecondOrderViewController
        if segue.identifier == "recommend" {
            secondViewController.secondLabel = firstLabel.text!
        } else if segue.identifier == "reserve" {
            secondViewController.secondLabel = secondLabel.text!
        } else if segue.identifier == "drip" {
            secondViewController.secondLabel = thirdLabel.text!
        }
        
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
