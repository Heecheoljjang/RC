//
//  ViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/19.
//

import UIKit

class HomeViewController: UIViewController {

    var HomeTableViewCellInfo: [HomeTableStruct] = []
    
    let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemOrange
        
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold) )
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        button.layer.shadowRadius = 45
        button.layer.shadowOpacity = 1
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg:
                                                        [UIImage(named: "iMac1")!, UIImage(named: "iMac2")!, UIImage(named: "iMac3")!, UIImage(named: "iMac4")!, UIImage(named: "iMac5")!, UIImage(named: "iPad1")!, UIImage(named: "iPad2")!, UIImage(named: "iPhone1")!, UIImage(named: "iPhone2")!, UIImage(named: "iPhone3")!, UIImage(named: "iPhone4")!, UIImage(named: "MacBook1")!, UIImage(named: "MacBook2")!, UIImage(named: "MacBook3")!, UIImage(named: "MacBook4")!],
                                                     titleLabel: ["iMaciMaciMaciMaciMaciMac","iMac2","iMac3","iMac4iMac4iMac4iMac4iMac4","iMac5","iPad1","iPad2","iPhone1","iPhone2","iPhone3","iPhone4","MacBook1","MacBook2","MacBook3","MacBook4"],
                                                     location: ["아아구 아아1동", "아아구 아아2동","아아구 아아3동","아아구 아아4동","아아구 아아5동","아아구 아아6동","아아구 아아7동","아아구 아아8동","아아구 아아9동","아아구 희희1동","아아구 희희2동","아아구 희희3동","아아구 희희4동","아아구 희희5동","아아구 희희6동"],
                                                     price: ["100,000","200,000","300,000","110,000","30,000","10,000","10,000","100,000","70,000","90,000","1,200,000","290,000","590,000","990,000","230,000"],
                                                     likeBtn: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]))
        
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
    }
    
    //Floating Button
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        floatingButton.frame = CGRect(x: view.frame.size.width - 50 - 17,
                                      y: view.frame.size.height - 50 - 10 - 80,
                                      width: 50,
                                      height: 50)
    }
    
    @objc func didTapBtn() {
        let sb = UIStoryboard(name: "AddContent", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddContent")
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeTableViewCellInfo[section].titleLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.itemImage.image = HomeTableViewCellInfo[indexPath.section].itemImg[indexPath.row]
        cell.titleLabel.text = HomeTableViewCellInfo[indexPath.section].titleLabel[indexPath.row]
        cell.locationLabel.text = HomeTableViewCellInfo[indexPath.section].location[indexPath.row]
        cell.priceLabel.text = HomeTableViewCellInfo[indexPath.section].price[indexPath.row]
        
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

struct HomeTableStruct {
    
    let itemImg: [UIImage]
    let titleLabel: [String]
    let location: [String]
    let price: [String]
    let likeBtn: [Bool]
}
