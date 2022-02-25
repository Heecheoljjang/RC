//
//  DetailViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyText: UILabel!

    var tempImage: UIImage?
    var tempLocation: String?
    var tempTitleLabel: String?
    var tempBodyText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        itemImage.image = tempImage
        location.text = tempLocation
        titleLabel.text = tempTitleLabel
        bodyText.text = tempBodyText
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    

}
