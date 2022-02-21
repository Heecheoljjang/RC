//
//  ViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/19.
//

import UIKit

class HomeViewController: UIViewController {

    let itemImg: [UIImage] = [
        UIImage(named: "iMac1")!,
        UIImage(named: "iMac2")!,
        UIImage(named: "iMac3")!,
        UIImage(named: "iMac4")!,
        UIImage(named: "iMac5")!,
        UIImage(named: "iPad1")!,
        UIImage(named: "iPad2")!,
        UIImage(named: "iPhone1")!,
        UIImage(named: "iPhone2")!,
        UIImage(named: "iPhone3")!,
        UIImage(named: "iPhone4")!,
        UIImage(named: "MacBook1")!,
        UIImage(named: "MacBook2")!,
        UIImage(named: "MacBook3")!,
        UIImage(named: "MacBook4")!]
    
    let titleLabel: [String] = [
        "iMaciMaciMaciMaciMaciMac","iMac2","iMac3","iMac4iMac4iMac4iMac4iMac4","iMac5","iPad1","iPad2","iPhone1","iPhone2","iPhone3","iPhone4","MacBook1","MacBook2","MacBook3","MacBook4"
    ]
    
    let location: [String] = [
        "아아구 아아1동", "아아구 아아2동","아아구 아아3동","아아구 아아4동","아아구 아아5동","아아구 아아6동","아아구 아아7동","아아구 아아8동","아아구 아아9동","아아구 희희1동","아아구 희희2동","아아구 희희3동","아아구 희희4동","아아구 희희5동","아아구 희희6동"
    ]
    
    let price: [String] = [
        "100,000원","200,000원","300,000원","110,000원","30,000원","10,000원","10,000원","100,000원","70,000원","90,000원","1,200,000원","290,000원","590,000원","990,000원","230,000원"
    ]
    
    let likeNum: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,11]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.itemImage.image = itemImg[indexPath.row]
        cell.titleLabel.text = titleLabel[indexPath.row]
        cell.locationLabel.text = location[indexPath.row]
        cell.priceLabel.text = price[indexPath.row]
        cell.likeNum.text = String(likeNum[indexPath.row])
        
        return cell
    }
    
    
}

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeNum: UILabel!

}
