//
//  ViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/19.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var homeTableView: UITableView!
    
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
        
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iMac1")!, titleLabel: "iMaciMaciMaciMaciMaciMac", location: "아아구 아아1동", price: "100,000", likeBtn: false, body: "아이맥1입니다."))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iMac2")!, titleLabel: "iMac2", location: "아아구 아아1동", price: "100,000", likeBtn: false, body: "아이맥2이입ㄴ디ㅏ"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iMac3")!, titleLabel: "iMac3", location: "아아구 아아1동", price: "200,000", likeBtn: false, body: "아이맥3입니다."))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iMac4")!, titleLabel: "iMac4iMac4iMac4iMac4iMac4", location: "아아구 아아1동", price: "300,000", likeBtn: false, body: "아이맥4인데 안팝니다"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iMac5")!, titleLabel: "iMac5", location: "아아구 아아1동", price: "110,000", likeBtn: false, body: "마지막 아이맥입니다."))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPad1")!, titleLabel: "iPad1", location: "아아구 아아1동", price: "30,000", likeBtn: false, body: "아이패드1입니다. "))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPad2")!, titleLabel: "iPad2", location: "아아구 아아1동", price: "10,000", likeBtn: false, body: "아이패드2입니다."))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPhone1")!, titleLabel: "iPhone1", location: "아아구 아아1동", price: "100,000", likeBtn: false, body: "아이폰1"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPhone2")!, titleLabel: "iPhone2", location: "아아구 아아1동", price: "1,200,000", likeBtn: false, body: "아이폰2"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPhone3")!, titleLabel: "iPhone3", location: "아아구 아아1동", price: "70,000", likeBtn: false, body: "아이폰3"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "iPhone4")!, titleLabel: "iPhone4", location: "아아구 아아1동", price: "100,000", likeBtn: false, body: "아이폰4"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "MacBook1")!, titleLabel: "MacBook1", location: "아아구 아아1동", price: "290,000", likeBtn: false, body: "맥북맥북"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "MacBook2")!, titleLabel: "MacBook2", location: "아아구 아아1동", price: "70,000", likeBtn: false, body: "맥북맥북맥북"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "MacBook3")!, titleLabel: "MacBook33434", location: "아아구 아아1동", price: "230,000", likeBtn: false, body: "맥북팔아요"))
        HomeTableViewCellInfo.append(HomeTableStruct(itemImg: UIImage(named: "MacBook4")!, titleLabel: "MacBook4234424", location: "아아구 아아1동", price: "100,000", likeBtn: false, body: "십만원에 팔아요"))
        
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(HomeTableViewCellInfo.count)
        homeTableView.reloadData()
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
        guard let vc = sb.instantiateViewController(withIdentifier: "AddContent") as? AddContentViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            HomeTableViewCellInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
}

extension HomeViewController: SendDataDelegate {
    func sendData(data: HomeTableStruct) {
        HomeTableViewCellInfo.insert(data, at: 0)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "detail") as? DetailViewController else { return }
    
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.tempImage = HomeTableViewCellInfo[indexPath.row].itemImg
        vc.tempLocation = HomeTableViewCellInfo[indexPath.row].location
        vc.tempTitleLabel = HomeTableViewCellInfo[indexPath.row].titleLabel
        vc.tempBodyText = HomeTableViewCellInfo[indexPath.row].body
    }
}

extension HomeViewController: UITableViewDataSource, CellButtonDelegate { //, CellButtonDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeTableViewCellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.index = indexPath.row
        
        cell.itemImage.image = HomeTableViewCellInfo[indexPath.row].itemImg
        cell.titleLabel.text = HomeTableViewCellInfo[indexPath.row].titleLabel
        cell.locationLabel.text = HomeTableViewCellInfo[indexPath.row].location
        cell.priceLabel.text = HomeTableViewCellInfo[indexPath.row].price
        
        //likeBtn의 값이 true면 하트가 눌렸다는 의미
        if HomeTableViewCellInfo[indexPath.row].likeBtn == true {
            cell.isTouched = true
        } else {
            cell.isTouched = false
        }
        
        return cell
    }
    
    func didTappedLikeBtn(index: Int, like: Bool) {
        if like == true {
            HomeTableViewCellInfo[index].likeBtn = true
        } else {
            HomeTableViewCellInfo[index].likeBtn = false
        }
    }
}


class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    var delegate: CellButtonDelegate?
    var index: Int?
    var isTapped: Bool = false
    
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        
        guard let index = index else { return }
        if isTapped == false {
            isTouched = true
            delegate?.didTappedLikeBtn(index: index, like: true)
            isTapped = true
        } else {
            isTouched = false
            delegate?.didTappedLikeBtn(index: index, like: false)
            isTapped = false
        }
        
    }

    var isTouched: Bool? {
        didSet {
            if isTouched == true {
                likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else if isTouched == false {
                likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
}

struct HomeTableStruct {
    
    var itemImg: UIImage
    var titleLabel: String
    var location: String
    var price: String
    var likeBtn: Bool
    var body: String
}
