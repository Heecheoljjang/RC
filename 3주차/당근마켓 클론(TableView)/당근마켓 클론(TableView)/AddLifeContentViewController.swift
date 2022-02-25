//
//  AddLifeContentViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/25.
//

import UIKit

class AddLifeContentViewController: UIViewController {

    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    var delegate: SendLifeTableDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyText.delegate = self
        
        bodyText.text = "게시글 내용을 작성해주세요."
        bodyText.textColor = UIColor.systemGray3

    }
    
    @IBAction func closeBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeBtn(_ sender: Any) {
        
        guard let category = categoryText.text else { return }
        guard let name = nameText.text else { return }
        guard let location = location.text else { return }
        guard let body = bodyText.text else { return }
        
        let data = LifeTableStruct(category: category, body: body, name: name, location: location)
        delegate?.sendData(data: data)
        
        self.dismiss(animated: true, completion: nil)
    }

    func textViewSetUp() {
        if bodyText.text == "게시글 내용을 작성해주세요." {
            bodyText.text = ""
            bodyText.textColor = UIColor.black
        } else if bodyText.text == "" {
            bodyText.text = "게시글 내용을 작성해주세요."
            bodyText.textColor = UIColor.systemGray3
        }
    }
}

//TextView PlaceHolder

extension AddLifeContentViewController: UITextViewDelegate {
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetUp()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewSetUp()
        }
    }
}
