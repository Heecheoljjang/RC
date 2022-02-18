//
//  OnlyIcedViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/18.
//

import UIKit

class OnlyIcedViewController: UIViewController {

    @IBOutlet weak var koreanName: UILabel!
    @IBOutlet weak var englishName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var hideLabel: UILabel!
    @IBOutlet weak var hideConst: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var orderButton: UIButton!
    
    var tempKorean: String = ""
    var tempEnglish: String = ""
    var tempPrice: String = ""
    var tempImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderButton.layer.cornerRadius = orderButton.frame.height / 2
        
        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.systemGray5.cgColor
        
        img.image = tempImg
        img.contentMode = .scaleToFill
        
        koreanName.text = tempKorean
        englishName.text = tempEnglish
        price.text = tempPrice
        
        if tempKorean == "봄 딸기 라떼" {
            info.text = "상금한 봄 딸기와 신선한 우유가 만나 부드럽고 달콤한 풍미를 느낄 수 있는 음료"
            hideView.isHidden = true
            hideConst.constant = 30
            viewHeight.constant = 900
        } else if tempKorean == "스프링 가든 자스민 드링크" {
            info.text = "설레이는 봄이 살랑거리며 피어오르는 모습을 형상화한 음료로 맛보는 순간 달콤한 향이 가득한 정원에 있는 듯한 느낌을 주는 음료"
            hideLabel.text = "* 타임(허브)의 수급 현황에 따라 타임 없이 제공 될 수 있습니다"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onlyIced" {
            
            let lastOrderViewController = segue.destination as! LastOrderViewController
            
            lastOrderViewController.tempName = koreanName.text
            lastOrderViewController.tempPrice = price.text
            lastOrderViewController.tempImg = img.image
            
        }
    }

}
