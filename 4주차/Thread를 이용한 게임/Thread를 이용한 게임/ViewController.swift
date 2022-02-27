//
//  ViewController.swift
//  Thread를 이용한 게임
//
//  Created by HeecheolYoon on 2022/02/26.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
// MARK: Outlets
    
    //타이머 Outlet
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timerBar: UIProgressView!
    
    //손님 Outlet
    @IBOutlet weak var firstGuestView: UIView!
    @IBOutlet weak var firstGuestLabel: UILabel!
    
    @IBOutlet weak var secondGuestView: UIView!
    @IBOutlet weak var secondGuestLabel: UILabel!
    
    @IBOutlet weak var thirdGuestView: UIView!
    @IBOutlet weak var thirdGuestLabel: UILabel!
    
    //목숨
    @IBOutlet weak var lifeView: UIView!
    @IBOutlet weak var lifeStackView: UIStackView!
    @IBOutlet weak var firstLife: UIImageView!
    @IBOutlet weak var secondLife: UIImageView!
    @IBOutlet weak var thirdLife: UIImageView!
    
    //점수
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //붕어빵 개수
    @IBOutlet weak var fishCount: UILabel!
    
    //현재 선택 라벨
    @IBOutlet weak var currentPickLabel: UILabel!
    
    //붕어빵 틀
    @IBOutlet weak var fishOne: UIImageView!
    @IBOutlet weak var fishTwo: UIImageView!
    @IBOutlet weak var fishThree: UIImageView!
    @IBOutlet weak var fishFour: UIImageView!
    @IBOutlet weak var fishFive: UIImageView!
    @IBOutlet weak var fishSix: UIImageView!
    @IBOutlet weak var fishSeven: UIImageView!
    @IBOutlet weak var fishEight: UIImageView!
    @IBOutlet weak var fishNine: UIImageView!
    
    //주전자, 팥, 손 이미지
    @IBOutlet weak var kettleView: UIView!
    @IBOutlet weak var redBeanView: UIView!
    @IBOutlet weak var handView: UIView!
        
    let total = 10
    var progressTime = 10
    var timer: Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        // MARK: UI
        timerView.layer.cornerRadius = 5
        
        lifeView.layer.cornerRadius = 5
        lifeStackView.layer.cornerRadius = 5
        scoreView.layer.cornerRadius = 5
        
        firstGuestView.layer.cornerRadius = 10
        secondGuestView.layer.cornerRadius = 10
        thirdGuestView.layer.cornerRadius = 10
        
        kettleView.layer.cornerRadius = 5
        kettleView.layer.masksToBounds = true
        redBeanView.layer.cornerRadius = 5
        redBeanView.layer.masksToBounds = true
        handView.layer.cornerRadius = 5
        handView.layer.masksToBounds = true

    }
    
    @objc func countDown() {
        progressTime -= 1
        timerBar.progress = Float(progressTime) / Float(total)
        
        if progressTime == 0 {
            timer?.invalidate()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }

        print(progressTime)
    }
}

