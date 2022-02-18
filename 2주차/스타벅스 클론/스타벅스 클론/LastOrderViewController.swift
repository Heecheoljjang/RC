//
//  LastOrderViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/16.
//

import UIKit
import UserNotifications

class LastOrderViewController: UIViewController {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var hideConstraint: NSLayoutConstraint!
    @IBOutlet weak var tallImg: UIImageView!
    @IBOutlet weak var grandeImg: UIImageView!
    @IBOutlet weak var ventiImg: UIImageView!
    @IBOutlet weak var tallView: UIView!
    @IBOutlet weak var grandeView: UIView!
    @IBOutlet weak var ventiView: UIView!
    @IBOutlet weak var tallLabel: UILabel!
    @IBOutlet weak var grandeLabel: UILabel!
    @IBOutlet weak var ventiLabel: UILabel!
    @IBOutlet weak var glassCup: UIButton!
    @IBOutlet weak var personalCup: UIButton!
    @IBOutlet weak var trashCup: UIButton!
    
    @IBOutlet weak var pickBtn: UIButton!
    @IBOutlet weak var orderBtn: UIButton!
    
    var count: Int = 1
    var tempName: String? = ""
    var tempPrice: String? = ""
    var intPrice: Int = 0
    var changePrice: Int = 0
    var tempImg: UIImage?
    
    var tallViewSelected: Bool?
    var grandeViewSelected: Bool?
    var ventiViewSelected: Bool?
    
    var glassSelected: Bool?
    var personalSelected: Bool?
    var trashSelected: Bool?
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickBtn.layer.cornerRadius = pickBtn.frame.height / 2
        orderBtn.layer.cornerRadius = orderBtn.frame.height / 2
        
        pickBtn.layer.borderWidth = 1
        pickBtn.layer.borderColor = UIColor(named: "starbucksLightGreen")?.cgColor
        
        
        countLabel.text = String(count)
        
        minusButton.tintColor = .systemGray5
        plusButton.tintColor = .darkGray
        
        if let temp = tempPrice, let value = Int(temp) {
            intPrice = value
            changePrice = value
        }
            
        itemLabel.text = tempName
        priceLabel.text = String(intPrice)
        
        hideView.isHidden = true
        hideConstraint.constant = 40
        
        //image
        tallImg.image = UIImage(named: "selectedCup")
        grandeImg.image = UIImage(named: "cup")
        ventiImg.image = UIImage(named: "cup")
        //border
        tallView.layer.borderWidth = 2
        tallView.layer.borderColor = UIColor(named: "starbucksLightGreen")?.cgColor
        
        grandeView.layer.borderWidth = 1
        grandeView.layer.borderColor = UIColor.systemGray.cgColor
        
        ventiView.layer.borderWidth = 1
        ventiView.layer.borderColor = UIColor.systemGray.cgColor
        
        tallView.layer.cornerRadius = 5
        grandeView.layer.cornerRadius = 5
        ventiView.layer.cornerRadius = 5

        //label
        tallLabel.textColor = .black
        grandeLabel.textColor = .darkGray
        ventiLabel.textColor = .darkGray
        
        //컵 선택 초기 상태
        //기본 테두리
        glassCup.layer.borderWidth = 1
        glassCup.layer.borderColor = UIColor.systemGray.cgColor
        personalCup.layer.borderColor = UIColor.systemGray.cgColor
        personalCup.layer.borderWidth = 1
        trashCup.layer.borderWidth = 1
        trashCup.layer.borderColor = UIColor.systemGray.cgColor
        
        glassCup.layer.cornerRadius = glassCup.frame.height / 2
        glassCup.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        
        trashCup.layer.cornerRadius = trashCup.frame.height / 2
        trashCup.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        //색(배경 글씨)
        glassCup.backgroundColor = UIColor(named: "starbucksLightGreen")
        glassCup.setTitleColor(.white, for: .normal)
        personalCup.backgroundColor = .white
        personalCup.setTitleColor(.darkGray, for: .normal)
        trashCup.backgroundColor = .white
        trashCup.setTitleColor(.darkGray, for: .normal)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "complete" {
            
            let completeViewController = segue.destination as! completeViewController
            
            completeViewController.tempMenu = tempName
            if tallViewSelected == true {
                completeViewController.tempSize = "Tall"
            } else if grandeViewSelected == true {
                completeViewController.tempSize = "Grande"
            } else {
                completeViewController.tempSize = "Venti"
            }
            completeViewController.tempImg = tempImg
            if glassSelected == true {
                completeViewController.tempCup = glassCup.title(for: .normal)
            } else if personalSelected == true {
                completeViewController.tempCup = personalCup.title(for: .normal)
            } else {
                completeViewController.tempCup = trashCup.title(for: .normal)
            }
            completeViewController.tempPrice = priceLabel.text
        }
    }

    @IBAction func minusBtn(_ sender: Any) {
        if count > 2 {
            count -= 1
            countLabel.text = String(count)
            if let priceText = priceLabel.text, var value = Int(priceText) {
                value -= changePrice
                priceLabel.text = String(value)
            }
        } else if count == 2 {
            count -= 1
            countLabel.text = String(count)
            if let priceText = priceLabel.text, var value = Int(priceText) {
                value -= changePrice
                priceLabel.text = String(value)
            }
            minusButton.tintColor = .systemGray5
        }
        
    }
    @IBAction func plusBtn(_ sender: Any) {
        count += 1
        countLabel.text = String(count)
        if let priceText = priceLabel.text, var value = Int(priceText) {
            value += changePrice
            priceLabel.text = String(value)
        }
        minusButton.tintColor = .darkGray
    }
    
    @IBAction func tapBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PersonalOption") as! PersonalOptionViewController
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func tapTallView(_ sender: Any) {
        tallImg.image = UIImage(named: "selectedCup")
        grandeImg.image = UIImage(named: "cup")
        ventiImg.image = UIImage(named: "cup")
        
        tallView.layer.borderWidth = 2
        tallView.layer.borderColor = UIColor(named: "starbucksLightGreen")?.cgColor
        
        grandeView.layer.borderWidth = 1
        grandeView.layer.borderColor = UIColor.systemGray.cgColor
        
        ventiView.layer.borderWidth = 1
        ventiView.layer.borderColor = UIColor.systemGray.cgColor
        
        tallLabel.textColor = .black
        grandeLabel.textColor = .darkGray
        ventiLabel.textColor = .darkGray
                
        changePrice = intPrice
        priceLabel.text = String(count * intPrice)
        
        tallViewSelected = true
        grandeViewSelected = false
        ventiViewSelected = false
    }
    @IBAction func tapGrandeView(_ sender: Any) {
        tallImg.image = UIImage(named: "cup")
        grandeImg.image = UIImage(named: "selectedCup")
        ventiImg.image = UIImage(named: "cup")
        
        grandeView.layer.borderWidth = 2
        grandeView.layer.borderColor = UIColor(named: "starbucksLightGreen")?.cgColor
        
        tallView.layer.borderWidth = 1
        tallView.layer.borderColor = UIColor.systemGray.cgColor
        
        ventiView.layer.borderWidth = 1
        ventiView.layer.borderColor = UIColor.systemGray.cgColor
        
        grandeLabel.textColor = .black
        tallLabel.textColor = .darkGray
        ventiLabel.textColor = .darkGray
        
        changePrice = intPrice + 500
        priceLabel.text = String(count * changePrice)
        
        tallViewSelected = false
        grandeViewSelected = true
        ventiViewSelected = false
    }
    @IBAction func tapVentiView(_ sender: Any) {
        tallImg.image = UIImage(named: "cup")
        ventiImg.image = UIImage(named: "selectedCup")
        grandeImg.image = UIImage(named: "cup")
        
        ventiView.layer.borderWidth = 2
        ventiView.layer.borderColor = UIColor(named: "starbucksLightGreen")?.cgColor
        
        tallView.layer.borderWidth = 1
        tallView.layer.borderColor = UIColor.systemGray.cgColor
        
        grandeView.layer.borderWidth = 1
        grandeView.layer.borderColor = UIColor.systemGray.cgColor
        
        ventiLabel.textColor = .black
        tallLabel.textColor = .darkGray
        grandeLabel.textColor = .darkGray
        
        changePrice = intPrice + 1000
        priceLabel.text = String(count * changePrice)
        
        tallViewSelected = false
        grandeViewSelected = false
        ventiViewSelected = true
    }
    //컵 선택 액션
    @IBAction func tapGlass(_ sender: Any) {
        hideView.isHidden = true
        hideConstraint.constant = 40
        
        glassCup.backgroundColor = UIColor(named: "starbucksLightGreen")
        glassCup.setTitleColor(.white, for: .normal)
        personalCup.backgroundColor = .white
        personalCup.setTitleColor(.darkGray, for: .normal)
        trashCup.backgroundColor = .white
        trashCup.setTitleColor(.darkGray, for: .normal)
        
        glassSelected = true
        personalSelected = false
        trashSelected = false
        
    }
    @IBAction func tapPersonal(_ sender: Any) {
        hideView.isHidden = false
        hideConstraint.constant = 210
        
        personalCup.backgroundColor = UIColor(named: "starbucksLightGreen")
        personalCup.setTitleColor(.white, for: .normal)
        glassCup.backgroundColor = .white
        glassCup.setTitleColor(.darkGray, for: .normal)
        trashCup.backgroundColor = .white
        trashCup.setTitleColor(.darkGray, for: .normal)
        
        glassSelected = false
        personalSelected = true
        trashSelected = false
    }
    @IBAction func tapTrash(_ sender: Any) {
        hideView.isHidden = true
        hideConstraint.constant = 40
        
        trashCup.backgroundColor = UIColor(named: "starbucksLightGreen")
        trashCup.setTitleColor(.white, for: .normal)
        personalCup.backgroundColor = .white
        personalCup.setTitleColor(.darkGray, for: .normal)
        glassCup.backgroundColor = .white
        glassCup.setTitleColor(.darkGray, for: .normal)
        
        glassSelected = false
        personalSelected = false
        trashSelected = true
    }
    
    @IBAction func tapOrderButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "주문이 정상적으로 접수되었습니다."
        content.body = ":)"
        
        let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: TimeIntervalTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
