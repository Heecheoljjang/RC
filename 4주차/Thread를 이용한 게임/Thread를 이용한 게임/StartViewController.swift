//
//  StartViewController.swift
//  Thread를 이용한 게임
//
//  Created by HeecheolYoon on 2022/02/28.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startBtnView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startBtnView.layer.cornerRadius = 15
        startBtnView.layer.borderWidth = 1
        startBtnView.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func start(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "main") as? MainViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
