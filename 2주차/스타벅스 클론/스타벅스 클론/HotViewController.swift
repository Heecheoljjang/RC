//
//  IcedAmericanoViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/13.
//

import UIKit

class HotViewController: UIViewController {

    @IBOutlet weak var koreanName: UILabel!
    @IBOutlet weak var englishName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var hotBtn: UIButton!
    @IBOutlet weak var icedBtn: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    
    var tempKorean: String = ""
    var tempEnglish: String = ""
    var tempPrice: String = ""
    var tempImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderButton.layer.cornerRadius = orderButton.frame.height / 2
        
        buttonView.layer.cornerRadius = buttonView.frame.height / 2
        hotBtn.layer.cornerRadius = hotBtn.frame.height / 2
        hotBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        icedBtn.layer.cornerRadius = hotBtn.frame.height / 2
        icedBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.gray.cgColor
        
        img.image = UIImage(named: "hot")
        img.contentMode = .scaleToFill
        
        koreanName.text = tempKorean
        englishName.text = tempEnglish
        price.text = tempPrice
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hotOrder" {
            
            let lastOrderViewController = segue.destination as! LastOrderViewController
            
            lastOrderViewController.tempName = koreanName.text
            lastOrderViewController.tempPrice = price.text
            lastOrderViewController.tempImg = img.image
        }
    }
    
    @IBAction func tapHotBtn(_ sender: Any) {
        koreanName.text = "카페 아메리카노"
        englishName.text = "Caffe Americano"
        info.text = "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피"
        hotBtn.backgroundColor = .red
        hotBtn.setTitleColor(.white, for: .normal)
        icedBtn.backgroundColor = .white
        icedBtn.setTitleColor(.darkGray, for: .normal)
        img.image = UIImage(named: "hot")
    }
    
    
    @IBAction func tapIcedBtn(_ sender: Any) {
        koreanName.text = "아이스 카페 아메리카노"
        englishName.text = "Iced Caffe Americano"
        info.text = "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피"
        hotBtn.backgroundColor = .white
        hotBtn.setTitleColor(.darkGray, for: .normal)
        icedBtn.backgroundColor = .link
        icedBtn.setTitleColor(.white, for: .normal)
        img.image = UIImage(named: "iced")
    }
}
