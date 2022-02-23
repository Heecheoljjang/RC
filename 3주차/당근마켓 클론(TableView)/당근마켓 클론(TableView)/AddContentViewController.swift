//
//  AddContentViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/24.
//

import UIKit

class AddContentViewController: UIViewController {

    @IBOutlet weak var bodyTextView: UITextView!
    
    
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
