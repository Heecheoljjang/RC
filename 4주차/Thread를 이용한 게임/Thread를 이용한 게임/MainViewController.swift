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
    var timeFirst = 20
    var timeSecond = 20
    var timeThird = 20

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
    var timerFirstGuest: Timer?
    var timerSecondGuest: Timer?
    var timerThirdGuest: Timer?
    
    var currentPick: String = "kettle"
    
    var totalCount: Int = 0
    var successCount: Int = 0
    var failCount: Int = 0
    var score: Int = 0
    var life: Int = 3

    let firstGuestTime = Int.random(in: 52...58)
    let secondGuestTime = Int.random(in: 35...40)
    let thirdGuestTime = Int.random(in: 24...30)
    
    
    let firstGuestNum = Int.random(in: 1...7)
    let secondGuestNum = Int.random(in: 1...7)
    let thirdGuestNum = Int.random(in: 1...7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstGuestLabel.text = "손님 1: 붕어빵 \(firstGuestNum)개 주세요."
        secondGuestLabel.text = "손님 2: 붕어빵 \(secondGuestNum)개 주세요."
        thirdGuestLabel.text = "손님 3: 붕어빵 \(thirdGuestNum)개 주세요."
                
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
            
            vc.tempFailureLabel = failCount
            vc.tempRestLabel = successCount
            vc.tempSellLabel = totalCount
            
            present(vc, animated: true, completion: nil)
        }
        
        if progressTime == firstGuestTime {
            firstGuestView.isHidden = false
            firstGuest()
        }
        
        if progressTime == secondGuestTime {
            secondGuestView.isHidden = false
            secondGuest()
        }
        
        if progressTime == thirdGuestTime {
            thirdGuestView.isHidden = false
            thirdGuest()
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
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerOne = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerOne), userInfo: nil, repeats: true)
                    while self.timeOne != 0 {
                        runLoop.run()
                    }
                }
                
            }
        } else if fishBreads[0].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishOne.image = UIImage(named: "2")
                fishBreads[0].currentStatus = 2
                fishBreads[0].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeOne <= 14 && timeOne >= 11 {
                    fishOne.image = UIImage(named: "3")
                    fishBreads[0].currentStatus = 3
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
                    totalCount += 1
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
                    scoreLabel.text = String(score)
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
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @objc func countTimerOne() {
        timeOne -= 1
        print(timeOne)
        if timeOne == 0 {
            timerOne?.invalidate()
        }
    }
// MARK: 두 번째 붕어빵 틀
    
    @IBAction func tapTwo(_ sender: Any) {
        if fishBreads[1].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishTwo.image = UIImage(named: "1")
                fishBreads[1].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerTwo = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerTwo), userInfo: nil, repeats: true)
                    while self.timeTwo != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[1].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishTwo.image = UIImage(named: "2")
                fishBreads[1].currentStatus = 2
                fishBreads[1].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeTwo <= 14 && timeTwo >= 11 {
                    fishTwo.image = UIImage(named: "3")
                    fishBreads[1].currentStatus = 3
                } else if timeTwo < 11 {
                    fishTwo.image = UIImage(named: "4")
                    fishBreads[1].currentStatus = 4
                }
            }
        } else if fishBreads[1].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeTwo <= 14 && timeTwo >= 11 {
                    fishTwo.image = UIImage(named: "3")
                    fishBreads[1].currentStatus = 3
                } else if timeTwo < 11 {
                    fishTwo.image = UIImage(named: "4")
                    fishBreads[1].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[1].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeTwo >= 1 && timeTwo <= 4 && fishBreads[1].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishTwo.image = UIImage(named: "0") // 초기화
                    timerTwo?.invalidate()
                    fishBreads[1].currentStatus = 0
                    fishBreads[1].isRedbeaned = false
                    timeTwo = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerTwo?.invalidate()
                        fishBreads[1].currentStatus = 0
                        fishBreads[1].isRedbeaned = false
                        fishTwo.image = UIImage(named: "0")
                        timeTwo = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerTwo?.invalidate()
                        fishBreads[1].currentStatus = 0
                        fishBreads[1].isRedbeaned = false
                        fishTwo.image = UIImage(named: "0")
                        timeTwo = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerTwo?.invalidate()
                    fishBreads[1].currentStatus = 0
                    fishBreads[1].isRedbeaned = false
                    fishTwo.image = UIImage(named: "0")
                    timeTwo = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerTwo?.invalidate()
                    fishBreads[1].currentStatus = 0
                    fishBreads[1].isRedbeaned = false
                    fishTwo.image = UIImage(named: "0")
                    timeTwo = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerTwo() {
        timeTwo -= 1
        print(timeTwo)
        if timeTwo == 0 {
            timerTwo?.invalidate()
        }
    }
// MARK: 세 번째 붕어빵 틀
    @IBAction func tapThree(_ sender: Any) {
        if fishBreads[2].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishThree.image = UIImage(named: "1")
                fishBreads[2].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerThree = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerThree), userInfo: nil, repeats: true)
                    while self.timeThree != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[2].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishThree.image = UIImage(named: "2")
                fishBreads[2].currentStatus = 2
                fishBreads[2].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeThree <= 14 && timeThree >= 11 {
                    fishThree.image = UIImage(named: "3")
                    fishBreads[2].currentStatus = 3
                } else if timeThree < 11 {
                    fishThree.image = UIImage(named: "4")
                    fishBreads[2].currentStatus = 4
                }
            }
        } else if fishBreads[2].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeThree <= 14 && timeThree >= 11 {
                    fishThree.image = UIImage(named: "3")
                    fishBreads[2].currentStatus = 3
                } else if timeThree < 11 {
                    fishTwo.image = UIImage(named: "4")
                    fishBreads[2].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[2].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeThree >= 1 && timeThree <= 4 && fishBreads[2].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishThree.image = UIImage(named: "0") // 초기화
                    timerThree?.invalidate()
                    fishBreads[2].currentStatus = 0
                    fishBreads[2].isRedbeaned = false
                    timeThree = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerThree?.invalidate()
                        fishBreads[2].currentStatus = 0
                        fishBreads[2].isRedbeaned = false
                        fishThree.image = UIImage(named: "0")
                        timeThree = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerThree?.invalidate()
                        fishBreads[2].currentStatus = 0
                        fishBreads[2].isRedbeaned = false
                        fishThree.image = UIImage(named: "0")
                        timeThree = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerThree?.invalidate()
                    fishBreads[2].currentStatus = 0
                    fishBreads[2].isRedbeaned = false
                    fishThree.image = UIImage(named: "0")
                    timeThree = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerThree?.invalidate()
                    fishBreads[2].currentStatus = 0
                    fishBreads[2].isRedbeaned = false
                    fishThree.image = UIImage(named: "0")
                    timeThree = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerThree() {
        timeThree -= 1
        print(timeThree)
        if timeThree == 0 {
            timerThree?.invalidate()
        }
    }
    
// MARK: 네 번째 붕어빵 틀
    @IBAction func tapFour(_ sender: Any) {
        if fishBreads[3].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishFour.image = UIImage(named: "1")
                fishBreads[3].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerFour = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerFour), userInfo: nil, repeats: true)
                    while self.timeFour != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[3].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishFour.image = UIImage(named: "2")
                fishBreads[3].currentStatus = 2
                fishBreads[3].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeFour <= 14 && timeFour >= 11 {
                    fishFour.image = UIImage(named: "3")
                    fishBreads[3].currentStatus = 3
                } else if timeFour < 11 {
                    fishFour.image = UIImage(named: "4")
                    fishBreads[3].currentStatus = 4
                }
            }
        } else if fishBreads[3].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeFour <= 14 && timeFour >= 11 {
                    fishFour.image = UIImage(named: "3")
                    fishBreads[3].currentStatus = 3
                } else if timeFour < 11 {
                    fishFour.image = UIImage(named: "4")
                    fishBreads[3].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[3].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeFour >= 1 && timeFour <= 4 && fishBreads[3].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishFour.image = UIImage(named: "0") // 초기화
                    timerFour?.invalidate()
                    fishBreads[3].currentStatus = 0
                    fishBreads[3].isRedbeaned = false
                    timeFour = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerFour?.invalidate()
                        fishBreads[3].currentStatus = 0
                        fishBreads[3].isRedbeaned = false
                        fishFour.image = UIImage(named: "0")
                        timeFour = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerFour?.invalidate()
                        fishBreads[3].currentStatus = 0
                        fishBreads[3].isRedbeaned = false
                        fishFour.image = UIImage(named: "0")
                        timeFour = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerFour?.invalidate()
                    fishBreads[3].currentStatus = 0
                    fishBreads[3].isRedbeaned = false
                    fishFour.image = UIImage(named: "0")
                    timeFour = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerFour?.invalidate()
                    fishBreads[3].currentStatus = 0
                    fishBreads[3].isRedbeaned = false
                    fishFour.image = UIImage(named: "0")
                    timeFour = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerFour() {
        timeFour -= 1
        if timeFour == 0 {
            timerFour?.invalidate()
        }
    }
    
// MARK: 다섯 번째 붕어빵 틀
    @IBAction func tapFive(_ sender: Any) {
        if fishBreads[4].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishFive.image = UIImage(named: "1")
                fishBreads[4].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerFive = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerFive), userInfo: nil, repeats: true)
                    while self.timeFive != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[4].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishFive.image = UIImage(named: "2")
                fishBreads[4].currentStatus = 2
                fishBreads[4].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeFive <= 14 && timeFive >= 11 {
                    fishFive.image = UIImage(named: "3")
                    fishBreads[4].currentStatus = 3
                } else if timeFive < 11 {
                    fishFive.image = UIImage(named: "4")
                    fishBreads[4].currentStatus = 4
                }
            }
        } else if fishBreads[4].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeFive <= 14 && timeFive >= 11 {
                    fishFive.image = UIImage(named: "3")
                    fishBreads[4].currentStatus = 3
                } else if timeFive < 11 {
                    fishFive.image = UIImage(named: "4")
                    fishBreads[4].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[4].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeFive >= 1 && timeFive <= 4 && fishBreads[4].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishFive.image = UIImage(named: "0") // 초기화
                    timerFive?.invalidate()
                    fishBreads[4].currentStatus = 0
                    fishBreads[4].isRedbeaned = false
                    timeFive = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerFive?.invalidate()
                        fishBreads[4].currentStatus = 0
                        fishBreads[4].isRedbeaned = false
                        fishFive.image = UIImage(named: "0")
                        timeFive = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerFive?.invalidate()
                        fishBreads[4].currentStatus = 0
                        fishBreads[4].isRedbeaned = false
                        fishFive.image = UIImage(named: "0")
                        timeFive = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerFive?.invalidate()
                    fishBreads[4].currentStatus = 0
                    fishBreads[4].isRedbeaned = false
                    fishFive.image = UIImage(named: "0")
                    timeFive = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerFive?.invalidate()
                    fishBreads[4].currentStatus = 0
                    fishBreads[4].isRedbeaned = false
                    fishFive.image = UIImage(named: "0")
                    timeFive = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerFive() {
        timeFive -= 1
        if timeFive == 0 {
            timerFive?.invalidate()
        }
    }
    
// MARK: 여섯 번째 붕어빵 틀
    @IBAction func tapSix(_ sender: Any) {
        if fishBreads[5].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishSix.image = UIImage(named: "1")
                fishBreads[5].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerSix = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerSix), userInfo: nil, repeats: true)
                    while self.timeSix != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[5].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishSix.image = UIImage(named: "2")
                fishBreads[5].currentStatus = 2
                fishBreads[5].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeSix <= 14 && timeSix >= 11 {
                    fishSix.image = UIImage(named: "3")
                    fishBreads[5].currentStatus = 3
                } else if timeSix < 11 {
                    fishSix.image = UIImage(named: "4")
                    fishBreads[5].currentStatus = 4
                }
            }
        } else if fishBreads[5].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeSix <= 14 && timeSix >= 11 {
                    fishSix.image = UIImage(named: "3")
                    fishBreads[5].currentStatus = 3
                } else if timeSix < 11 {
                    fishSix.image = UIImage(named: "4")
                    fishBreads[5].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[5].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeSix >= 1 && timeSix <= 4 && fishBreads[5].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishSix.image = UIImage(named: "0") // 초기화
                    timerSix?.invalidate()
                    fishBreads[5].currentStatus = 0
                    fishBreads[5].isRedbeaned = false
                    timeSix = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerSix?.invalidate()
                        fishBreads[5].currentStatus = 0
                        fishBreads[5].isRedbeaned = false
                        fishSix.image = UIImage(named: "0")
                        timeSix = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerSix?.invalidate()
                        fishBreads[5].currentStatus = 0
                        fishBreads[5].isRedbeaned = false
                        fishSix.image = UIImage(named: "0")
                        timeSix = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerSix?.invalidate()
                    fishBreads[5].currentStatus = 0
                    fishBreads[5].isRedbeaned = false
                    fishSix.image = UIImage(named: "0")
                    timeSix = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerSix?.invalidate()
                    fishBreads[5].currentStatus = 0
                    fishBreads[5].isRedbeaned = false
                    fishSix.image = UIImage(named: "0")
                    timeSix = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerSix() {
        timeSix -= 1
        if timeSix == 0 {
            timerSix?.invalidate()
        }
    }
    
// MARK: 일곱 번째 붕어빵 틀
    @IBAction func tapSeven(_ sender: Any) {
        if fishBreads[6].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishSeven.image = UIImage(named: "1")
                fishBreads[6].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerSeven = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerSeven), userInfo: nil, repeats: true)
                    while self.timeSeven != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[6].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishSeven.image = UIImage(named: "2")
                fishBreads[6].currentStatus = 2
                fishBreads[6].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeSeven <= 14 && timeSeven >= 11 {
                    fishSeven.image = UIImage(named: "3")
                    fishBreads[6].currentStatus = 3
                } else if timeSeven < 11 {
                    fishSeven.image = UIImage(named: "4")
                    fishBreads[6].currentStatus = 4
                }
            }
        } else if fishBreads[6].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeSeven <= 14 && timeSeven >= 11 {
                    fishSeven.image = UIImage(named: "3")
                    fishBreads[6].currentStatus = 3
                } else if timeSeven < 11 {
                    fishSeven.image = UIImage(named: "4")
                    fishBreads[6].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[6].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeSeven >= 1 && timeSeven <= 4 && fishBreads[6].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishSeven.image = UIImage(named: "0") // 초기화
                    timerSeven?.invalidate()
                    fishBreads[6].currentStatus = 0
                    fishBreads[6].isRedbeaned = false
                    timeSeven = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerSeven?.invalidate()
                        fishBreads[6].currentStatus = 0
                        fishBreads[6].isRedbeaned = false
                        fishSeven.image = UIImage(named: "0")
                        timeSeven = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerSeven?.invalidate()
                        fishBreads[6].currentStatus = 0
                        fishBreads[6].isRedbeaned = false
                        fishSeven.image = UIImage(named: "0")
                        timeSeven = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerSeven?.invalidate()
                    fishBreads[6].currentStatus = 0
                    fishBreads[6].isRedbeaned = false
                    fishSeven.image = UIImage(named: "0")
                    timeSeven = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerSeven?.invalidate()
                    fishBreads[6].currentStatus = 0
                    fishBreads[6].isRedbeaned = false
                    fishSeven.image = UIImage(named: "0")
                    timeSeven = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerSeven() {
        timeSeven -= 1
        if timeSeven == 0 {
            timerSeven?.invalidate()
        }
    }
    
// MARK: 여덟 번째 붕어빵 틀
    @IBAction func tapEight(_ sender: Any) {
        if fishBreads[7].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishEight.image = UIImage(named: "1")
                fishBreads[7].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerEight = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerEight), userInfo: nil, repeats: true)
                    while self.timeEight != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[7].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishEight.image = UIImage(named: "2")
                fishBreads[7].currentStatus = 2
                fishBreads[7].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeEight <= 14 && timeEight >= 11 {
                    fishEight.image = UIImage(named: "3")
                    fishBreads[7].currentStatus = 3
                } else if timeEight < 11 {
                    fishEight.image = UIImage(named: "4")
                    fishBreads[7].currentStatus = 4
                }
            }
        } else if fishBreads[7].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeEight <= 14 && timeEight >= 11 {
                    fishEight.image = UIImage(named: "3")
                    fishBreads[7].currentStatus = 3
                } else if timeEight < 11 {
                    fishEight.image = UIImage(named: "4")
                    fishBreads[7].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[7].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeEight >= 1 && timeEight <= 4 && fishBreads[7].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishEight.image = UIImage(named: "0") // 초기화
                    timerEight?.invalidate()
                    fishBreads[7].currentStatus = 0
                    fishBreads[7].isRedbeaned = false
                    timeEight = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerEight?.invalidate()
                        fishBreads[7].currentStatus = 0
                        fishBreads[7].isRedbeaned = false
                        fishEight.image = UIImage(named: "0")
                        timeEight = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerEight?.invalidate()
                        fishBreads[7].currentStatus = 0
                        fishBreads[7].isRedbeaned = false
                        fishEight.image = UIImage(named: "0")
                        timeEight = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerEight?.invalidate()
                    fishBreads[7].currentStatus = 0
                    fishBreads[7].isRedbeaned = false
                    fishEight.image = UIImage(named: "0")
                    timeEight = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerEight?.invalidate()
                    fishBreads[7].currentStatus = 0
                    fishBreads[7].isRedbeaned = false
                    fishEight.image = UIImage(named: "0")
                    timeEight = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerEight() {
        timeEight -= 1
        if timeEight == 0 {
            timerEight?.invalidate()
        }
    }
    
// MARK: 아홉 번째 붕어빵 틀
    @IBAction func tapNine(_ sender: Any) {
        if fishBreads[8].currentStatus == 0 { // 빈 틀
            if currentPick == "kettle" {
                fishNine.image = UIImage(named: "1")
                fishBreads[8].currentStatus = 1
                DispatchQueue.global().async {
                    let runLoop = RunLoop.current
                    self.timerNine = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTimerNine), userInfo: nil, repeats: true)
                    while self.timeNine != 0 {
                        runLoop.run()
                    }
                }
            }
        } else if fishBreads[8].currentStatus == 1 { // 반죽만 들어간 상태
            if currentPick == "redbean" {
                fishNine.image = UIImage(named: "2")
                fishBreads[8].currentStatus = 2
                fishBreads[8].isRedbeaned = true
                
            } else if currentPick == "hand" { // 팥 안넣고 뒤집음
                if timeNine <= 14 && timeNine >= 11 {
                    fishNine.image = UIImage(named: "3")
                    fishBreads[8].currentStatus = 3
                } else if timeNine < 11 {
                    fishNine.image = UIImage(named: "4")
                    fishBreads[8].currentStatus = 4
                }
            }
        } else if fishBreads[8].currentStatus == 2 { // 팥까지 들어간 상태
            if currentPick == "hand" {
                if timeNine <= 14 && timeNine >= 11 {
                    fishNine.image = UIImage(named: "3")
                    fishBreads[8].currentStatus = 3
                } else if timeNine < 11 {
                    fishNine.image = UIImage(named: "4")
                    fishBreads[8].currentStatus = 4 // 4는 탄 거
                }
            }
        } else if fishBreads[8].currentStatus == 3 { // 한 쪽은 다 익은 상태
            if currentPick == "hand" {
                if timeNine >= 1 && timeNine <= 4 && fishBreads[8].isRedbeaned == true {
                    successCount += 1
                    totalCount += 1
                    fishCountLabel.text = String(successCount)
                    fishNine.image = UIImage(named: "0") // 초기화
                    timerNine?.invalidate()
                    fishBreads[8].currentStatus = 0
                    fishBreads[8].isRedbeaned = false
                    timeNine = 20
                } else {
                    failCount += 1
                    failCountLabel.text = String(failCount)
                    score -= 500 //500원 손해
                    scoreLabel.text = String(score)
                    if life == 3{
                        life -= 1
                        firstLife.tintColor = UIColor(named: "newGreen")
                        timerNine?.invalidate()
                        fishBreads[8].currentStatus = 0
                        fishBreads[8].isRedbeaned = false
                        fishNine.image = UIImage(named: "0")
                        timeNine = 20

                    } else if life == 2{
                        life -= 1
                        secondLife.tintColor = UIColor(named: "newGreen")
                        timerNine?.invalidate()
                        fishBreads[8].currentStatus = 0
                        fishBreads[8].isRedbeaned = false
                        fishNine.image = UIImage(named: "0")
                        timeNine = 20

                    } else if life == 1{
                        mainTimer?.invalidate()
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                        vc.modalPresentationStyle = .fullScreen
                        vc.tempFailureLabel = failCount
                        vc.tempRestLabel = successCount
                        vc.tempSellLabel = totalCount
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
                    timerNine?.invalidate()
                    fishBreads[8].currentStatus = 0
                    fishBreads[8].isRedbeaned = false
                    fishNine.image = UIImage(named: "0")
                    timeNine = 20

                } else if life == 2{
                    life -= 1
                    secondLife.tintColor = UIColor(named: "newGreen")
                    timerNine?.invalidate()
                    fishBreads[8].currentStatus = 0
                    fishBreads[8].isRedbeaned = false
                    fishNine.image = UIImage(named: "0")
                    timeNine = 20

                } else if life == 1{
                    mainTimer?.invalidate()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                    vc.modalPresentationStyle = .fullScreen
                    vc.tempFailureLabel = failCount
                    vc.tempRestLabel = successCount
                    vc.tempSellLabel = totalCount
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func countTimerNine() {
        timeNine -= 1
        if timeNine == 0 {
            timerNine?.invalidate()
        }
    }
    
    // MARK: 손님 함수 타이머
    // 첫번째 손님
    private func firstGuest() {
        timerFirstGuest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(firstGuestCountDown), userInfo: nil, repeats: true)
    }
    @objc func firstGuestCountDown() {
        timeFirst -= 1
        if timeFirst == 0 {
            timerFirstGuest?.invalidate()
            firstGuestLabel.text = "손님 1: 안먹습니다."
            if life == 3{
                life -= 1
                firstLife.tintColor = UIColor(named: "newGreen")
            } else if life == 2{
                life -= 1
                secondLife.tintColor = UIColor(named: "newGreen")
            } else {
                mainTimer?.invalidate()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.tempFailureLabel = failCount
                vc.tempRestLabel = successCount
                vc.tempSellLabel = totalCount
                present(vc, animated: true, completion: nil)
            }
            timeFirst = 20
        }
    }
    
    // 두번째 손님
    private func secondGuest() {
        timerSecondGuest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondGuestCountDown), userInfo: nil, repeats: true)
    }
    @objc func secondGuestCountDown() {
        timeSecond -= 1
        if timeSecond == 0 {
            timerSecondGuest?.invalidate()
            secondGuestLabel.text = "손님 2: 안먹습니다."
            if life == 3{
                life -= 1
                firstLife.tintColor = UIColor(named: "newGreen")
            } else if life == 2{
                life -= 1
                secondLife.tintColor = UIColor(named: "newGreen")
            } else {
                mainTimer?.invalidate()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.tempFailureLabel = failCount
                vc.tempRestLabel = successCount
                vc.tempSellLabel = totalCount
                present(vc, animated: true, completion: nil)
            }
            timeSecond = 20
        }
    }
    
    // 세번째 손님
    private func thirdGuest() {
        timerThirdGuest = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(thirdGuestCountDown), userInfo: nil, repeats: true)
    }
    @objc func thirdGuestCountDown() {
        timeThird -= 1
        if timeThird == 0 {
            timerThirdGuest?.invalidate()
            thirdGuestLabel.text = "손님 3: 안먹습니다."
            if life == 3{
                life -= 1
                firstLife.tintColor = UIColor(named: "newGreen")
            } else if life == 2{
                life -= 1
                secondLife.tintColor = UIColor(named: "newGreen")
            } else {
                mainTimer?.invalidate()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                vc.tempFailureLabel = failCount
                vc.tempRestLabel = successCount
                vc.tempSellLabel = totalCount
                present(vc, animated: true, completion: nil)
            }
            timeThird = 20
        }
    }
    @IBAction func tapFirstGuest(_ sender: Any) {
        if successCount >= firstGuestNum { // 팔 개수가 있는 경우
            successCount -= firstGuestNum
            score += 1000 * firstGuestNum
            scoreLabel.text = String(score)
            fishCountLabel.text = String(successCount)
            timerFirstGuest?.invalidate()
            firstGuestLabel.text = "감사합니다. 잘 먹겠습니다."
            UIView.animate(withDuration: 1) {
                self.firstGuestView.alpha = 0
            }
        }
    }
    @IBAction func tapSecondGuest(_ sender: Any) {
        if successCount >= secondGuestNum { // 팔 개수가 있는 경우
            successCount -= secondGuestNum
            score += 1000 * secondGuestNum
            scoreLabel.text = String(score)
            fishCountLabel.text = String(successCount)
            timerSecondGuest?.invalidate()
            secondGuestLabel.text = "감사합니다. 잘 먹겠습니다."
            UIView.animate(withDuration: 1) {
                self.secondGuestView.alpha = 0
            }
        }
    }
    @IBAction func tapThirdGuest(_ sender: Any) {
        if successCount >= thirdGuestNum { // 팔 개수가 있는 경우
            successCount -= thirdGuestNum
            score += 1000 * thirdGuestNum
            scoreLabel.text = String(score)
            fishCountLabel.text = String(successCount)
            timerThirdGuest?.invalidate()
            thirdGuestLabel.text = "감사합니다. 잘 먹겠습니다."
            UIView.animate(withDuration: 1) {
                self.thirdGuestView.alpha = 0
            }
        }
    }
}

struct fishBread {
    var currentStatus: Int
    var isRedbeaned: Bool
}
