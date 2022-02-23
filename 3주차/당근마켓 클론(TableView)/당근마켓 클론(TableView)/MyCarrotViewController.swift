//
//  MyCarrotViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/23.
//

import UIKit

class MyCarrotViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myTableViewXib = UINib(nibName: "MyTableViewCell", bundle: nil)
        self.myTableView.register(myTableViewXib, forCellReuseIdentifier: "cell")
        
        myTableView.alwaysBounceVertical = false
        
    }

}

extension MyCarrotViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 2
        } else if section == 3 {
            return 3
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCarrotTableViewCell else { return UITableViewCell() }
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}

extension MyCarrotViewController: UITableViewDelegate {
    
}

class MyCarrotTableViewCell: UITableViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

