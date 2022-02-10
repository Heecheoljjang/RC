//
//  ViewController.swift
//  SpotifyUI
//
//  Created by 희철 on 2022/02/05.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstLeella: UIImageView!
    @IBOutlet weak var firstIU: UIImageView!
    @IBOutlet weak var homies: UIView!
    @IBOutlet weak var secondLeella: UIImageView!
    @IBOutlet weak var cheeze: UIImageView!
    @IBOutlet weak var paulKim: UIImageView!
    @IBOutlet weak var huh: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstLeella.layer.cornerRadius = firstLeella.frame.width / 2
        firstLeella.clipsToBounds = true
        firstIU.layer.cornerRadius = firstIU.frame.width / 2
        firstIU.clipsToBounds = true
        homies.layer.cornerRadius = homies.frame.width / 2
        homies.clipsToBounds = true
        secondLeella.layer.cornerRadius = secondLeella.frame.width / 2
        secondLeella.clipsToBounds = true
        cheeze.layer.cornerRadius = cheeze.frame.width / 2
        cheeze.clipsToBounds = true
        paulKim.layer.cornerRadius = paulKim.frame.width / 2
        paulKim.clipsToBounds = true
        huh.layer.cornerRadius = huh.frame.width / 2
        huh.clipsToBounds = true
    }


}

