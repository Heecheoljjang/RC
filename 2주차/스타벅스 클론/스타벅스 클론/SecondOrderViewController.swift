//
//  SecondOrderViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/13.
//

import UIKit

class SecondOrderViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var iced: UILabel!
    @IBOutlet weak var icedEnglish: UILabel!
    @IBOutlet weak var icedPrice: UILabel!
    @IBOutlet weak var icedImg: UIImageView!
    @IBOutlet weak var hotImg: UIImageView!
    @IBOutlet weak var hotEnglish: UILabel!
    

    @IBOutlet weak var jasmineImg: UIImageView!
    @IBOutlet weak var strawberryImg: UIImageView!
    @IBOutlet weak var strawberryPrice: UILabel!
    @IBOutlet weak var strawberryEnglish: UILabel!
    @IBOutlet weak var strawberry: UILabel!
    @IBOutlet weak var jasmine: UILabel!
    @IBOutlet weak var hot: UILabel!
    @IBOutlet weak var jasmineEnglish: UILabel!
    @IBOutlet weak var jasminePrice: UILabel!
    
    var secondLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = secondLabel
        
        icedImg.layer.cornerRadius = icedImg.frame.height / 2
        
        hotImg.layer.cornerRadius = hotImg.frame.height / 2
        
        strawberryImg.layer.cornerRadius = strawberryImg.frame.height / 2
        
        jasmineImg.layer.cornerRadius = jasmineImg.frame.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "icedAmericano" {
            let icedViewController = segue.destination as! IcedViewController

            guard let koreanText = iced.text else {return}
            guard let englishText = icedEnglish.text else { return }
            guard let priceText = icedPrice.text else { return }
            guard let tempImg = icedImg.image else {return}
            
            icedViewController.tempKorean = koreanText
            icedViewController.tempEnglish = englishText
            icedViewController.tempPrice = priceText
            icedViewController.tempImg = tempImg
            
            
        } else if segue.identifier == "hotAmericano" {
            let hotViewController = segue.destination as! HotViewController

            guard let koreanText = hot.text else {return}
            guard let englishText = hotEnglish.text else { return }
            guard let priceText = icedPrice.text else { return }
            guard let tempImg = hotImg.image else {return}
            
            
            hotViewController.tempKorean = koreanText
            hotViewController.tempEnglish = englishText
            hotViewController.tempPrice = priceText
            hotViewController.tempImg = tempImg

        } else if segue.identifier == "springStrawberry" {
            let onlyIcedViewController = segue.destination as! OnlyIcedViewController
            
            guard let koreanText = strawberry.text else {return}
            guard let englishText = strawberryEnglish.text else { return }
            guard let priceText = strawberryPrice.text else { return }
            guard let tempImg = strawberryImg.image else {return}
            
            onlyIcedViewController.tempKorean = koreanText
            onlyIcedViewController.tempEnglish = englishText
            onlyIcedViewController.tempPrice = priceText
            onlyIcedViewController.tempImg = tempImg
            
        } else if segue.identifier == "jasmine" {
            let onlyIcedViewController = segue.destination as! OnlyIcedViewController
            
            guard let koreanText = jasmine.text else {return}
            guard let englishText = jasmineEnglish.text else { return }
            guard let priceText = jasminePrice.text else { return }
            guard let tempImg = jasmineImg.image else {return}
            
            onlyIcedViewController.tempKorean = koreanText
            onlyIcedViewController.tempEnglish = englishText
            onlyIcedViewController.tempPrice = priceText
            onlyIcedViewController.tempImg = tempImg
        }
    }
    
}
