//
//  AddContentViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/24.
//

import UIKit

class AddContentViewController: UIViewController {

    var delegate: SendDataDelegate?
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var imgName: UITextField!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderSetting()
        if bodyTextView.allowsEditingTextAttributes == true {
            textViewDidBeginEditing(bodyTextView)
        }

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
        guard let body = bodyTextView.text else { return }

        let data = HomeTableStruct(itemImg: image, titleLabel: titleText, location: location, price: price, likeBtn: false, body: body)
        delegate?.sendData(data: data)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}

//TextView PlaceHolder

extension AddContentViewController: UITextViewDelegate {
    
    func placeholderSetting() {
        bodyTextView.delegate = self
        bodyTextView.text = "동네에 올릴 게시글 내용을 작성해주세요."
        bodyTextView.textColor = UIColor.systemGray3
            
        }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "동네에 올릴 게시글 내용을 작성해주세요."
            textView.textColor = UIColor.systemGray3
        }
    }
}
