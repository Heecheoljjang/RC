//
//  AddContentViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/24.
//

import UIKit

class AddContentViewController: UIViewController {

    var delegate: SendDataDelegate?
    
    @IBOutlet weak var imgName: UITextField!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyText.delegate = self
        
        bodyText.text = "동동에 올릴 게시글 내용을 작성해주세요."
        bodyText.textColor = UIColor.systemGray3

    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func completeBtn(_ sender: Any) {

        guard let imageText = imgName.text else { return }
        guard let titleText = textTitle.text else { return }
        guard let location = location.text else { return }
        guard let price = price.text else { return }
        guard let image = UIImage(named: imageText) else { return }
        guard let body = bodyText.text else { return }

        let data = HomeTableStruct(itemImg: image, titleLabel: titleText, location: location, price: numberFormatter(number: Int(price)!), likeBtn: false, body: body)
        delegate?.sendData(data: data)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    func textViewSetUp() {
        if bodyText.text == "동동에 올릴 게시글 내용을 작성해주세요." {
            bodyText.text = ""
            bodyText.textColor = UIColor.black
        } else if bodyText.text == "" {
            bodyText.text = "동동에 올릴 게시글 내용을 작성해주세요."
            bodyText.textColor = UIColor.systemGray3
        }
    }
}

//TextView PlaceHolder

extension AddContentViewController: UITextViewDelegate {
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetUp()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewSetUp()
        }
    }
}
