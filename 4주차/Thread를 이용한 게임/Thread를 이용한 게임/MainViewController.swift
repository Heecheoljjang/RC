//
//  ViewController.swift
//  Thread를 이용한 게임
//
//  Created by HeecheolYoon on 2022/02/26.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
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
    @IBOutlet weak var fishCountLabel: UILabel!
    @IBOutlet weak var failCountLabel: UILabel!
    
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
        
    let total = 70 //메인 타이머 시간
    var progressTime = 70
    var fishBreads = [fishBread](repeating: fishBread(currentStatus: 0, isRedbeaned: false), count: 9)
    
    //각 붕어빵 틀 타이머
    var timeOne = 20
    var timeTwo = 20
    var timeThree = 20
    var timeFour = 20
    var timeFive = 20
    var timeSix = 20
    var timeSeven = 20
    var timeEight = 20
    var timeNine = 20

    var mainTimer: Timer?
    var timerOne: Timer?
    var timerTwo: Timer?
    var timerThree: Timer?
    var timerFour: Timer?
    var timerFive: Timer?
    var timerSix: Timer?
    var timerSeven: Timer?
    var timerEight: Timer?
    var timerNine: Timer?
    
    var currentPick: String = "kettle"
    
    var successCount: Int = 0
    var failCount: Int = 0
    var score: Int = 0
    var life: Int = 3

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
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
    //메인 타이머 함수
    @objc func countDown() {
        progressTime -= 1
        timerBar.progress = Float(progressTime) / Float(total)
        
        if progressTime == 0 {
            mainTimer?.invalidate()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }

        print(progressTime)
    }
    
    @IBAction func pickHand(_ sender: Any) {
        currentPick = "hand"
        currentPickLabel.text = "손"
    }
    @IBAction func pickRedbean(_ sender: Any) {
        currentPick = "redbean"
        currentPickLabel.text = "팥"
    }
    @IBAction func pickKettle(_ sender: Any) {
        currentPick = "kettle"
        currentPickLabel.text = "주전자"
    }
    
// MARK: 첫 번째 붕어빵 틀
    
    @IBAction func tapOne(_ sender: Any) {
        if fishBreads[0].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishOne.image = UIImage(named: "1")
                fishBreads[0].currentStatus = 1
                timerOne = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimerOne), userInfo: nil, repeats: true)
            }
        } else if fishBreads[0].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishOne.image = UIImage(named: "2")
                fishBreads[0].currentStatus = 2
                fishBreads[0].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeOne <= 14 && timeOne >= 11 {
                    fishOne.image = UIImage(named: "3")
                    fishBreads[0].currentStatus = 2
                } else if timeOne < 11 {
                    fishOne.image = UIImage(named: "4")
                    fishBreads[0].currentStatus = 4
                }
            }
        } else if fishBreads[0].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeOne <= 14 && timeOne >= 11 {
                    fishOne.image = UIImage(named: "3")
                    fishBreads[0].currentStatus = 3
                } else if timeOne < 11 {
                    fishOne.image = UIImage(named: "4")
                    fishBreads[0].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[0].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeOne >= 1 && timeOne <= 4 && fishBreads[0].isRedbeaned == true {
                    successCount += 1
                    fishCountLabel.text = String(successCount)
                    fishOne.image = UIImage(named: "0") // 초기화
                    timerOne?.invalidate()
                    fishBreads[0].currentStatus = 0
                    fishBreads[0].isRedbeaned = false
                    timeOne = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerOne?.invalidate()
                        fishBreads[0].currentStatus = 0
                        fishBreads[0].isRedbeaned = false
                        fishOne.image = UIImage(named: "0")
                        timeOne = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerOne?.invalidate()
                        fishBreads[0].currentStatus = 0
                        fishBreads[0].isRedbeaned = false
                        fishOne.image = UIImage(named: "0")
                        timeOne = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        present(vc, animated: true, completion: nil)
                    }
                }
            }
        } else {
            if currentPick == "hand" {
                failCount += 1
                failCountLabel.text = String(failCount)
                score -= 500 //500원 손해
                if life == 3{
                    life -= 1
                    firstLife.tintColor = UIColor(named: "newGreen")
                    timerOne?.invalidate()
                    fishBreads[0].currentStatus = 0
                    fishBreads[0].isRedbeaned = false
                    fishOne.image = UIImage(named: "0")
                    timeOne = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerOne?.invalidate()
                    fishBreads[0].currentStatus = 0
                    fishBreads[0].isRedbeaned = false
                    fishOne.image = UIImage(named: "0")
                    timeOne = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc func countTimerOne() {
        timeOne -= 1
        print(timeOne)
        if timeOne == 0 {
            print("first end")
            timerOne?.invalidate()
            fishOne.image = UIImage(named: "2")
        }
    }
}

struct fishBread {
    var currentStatus: Int
    var isRedbeaned: Bool
}
