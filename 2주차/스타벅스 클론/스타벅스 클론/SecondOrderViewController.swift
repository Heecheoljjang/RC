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
    

    @IBOutlet weak var strawberry: UILabel!
    @IBOutlet weak var jasmine: UILabel!
    @IBOutlet weak var hot: UILabel!
    
    var secondLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = secondLabel
        
        icedImg.layer.cornerRadius = icedImg.frame.height / 2
        
        hotImg.layer.cornerRadius = hotImg.frame.height / 2
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
            
            
        }
    }
    
}
