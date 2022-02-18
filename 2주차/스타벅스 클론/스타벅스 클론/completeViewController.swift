//
//  completeViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/18.
//

import UIKit

class completeViewController: UIViewController {

    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var cup: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    var tempMenu: String?
    var tempImg: UIImage?
    var tempSize: String?
    var tempCup: String?
    var tempPrice: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuImg.layer.cornerRadius = menuImg.frame.height / 2
        
        menuImg.image = tempImg
        menuTitle.text = tempMenu
        size.text = tempSize
        cup.text = tempCup
        price.text = tempPrice
    }

    @IBAction func goHome(_ sender: Any) {
        self.performSegue(withIdentifier: "unwind", sender: self)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
