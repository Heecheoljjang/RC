//
//  MyCarrotViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/23.
//

import UIKit

class MyCarrotViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var dotLineView: UIView!
    
    var tableViewCellInfo: [TableViewCell] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableViewCellInfo.append(TableViewCell(section: 0, image: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!], title: ["내 동네 설정", "동네 인증하기", "키워드 알림", "관심 카테고리 설정"]))
        tableViewCellInfo.append(TableViewCell(section: 1, image: [UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!], title: ["모아보기", "당근가계부", "받은 쿠폰함", "내 단골 가게"]))
        tableViewCellInfo.append(TableViewCell(section: 2, image: [UIImage(named: "9")!, UIImage(named: "10")!], title: ["동네생활 글/댓글", "동네 가게 후기"]))
        tableViewCellInfo.append(TableViewCell(section: 3, image: [UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!], title: ["비즈프로필 만들기", "동네홍보 글", "지역광고"]))
        tableViewCellInfo.append(TableViewCell(section: 4, image: [UIImage(named: "14")!, UIImage(named: "15")!, UIImage(named: "16")!, UIImage(named: "17")!, UIImage(named: "18")!], title: ["친구초대", "당근마켓 공유", "공지사항", "자주 묻는 질문", "앱 설정"]))
        
        let myTableViewXib = UINib(nibName: "MyTableViewCell", bundle: nil)
        self.myTableView.register(myTableViewXib, forCellReuseIdentifier: "cell")
        
        myTableView.alwaysBounceVertical = false
        dotLineView.layer.borderWidth = 1
        dotLineView.layer.borderColor = UIColor.systemOrange.cgColor
        
    }
}

extension MyCarrotViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewCellInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCellInfo[section].image.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCarrotTableViewCell else { return UITableViewCell() }
    
        cell.settingImg.image = tableViewCellInfo[indexPath.section].image[indexPath.row]
        cell.settingTitle.text = tableViewCellInfo[indexPath.section].title[indexPath.row]
        
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
    
    @IBOutlet weak var settingTitle: UILabel!
    @IBOutlet weak var settingImg: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

struct TableViewCell {
    let section: Int
    let image: [UIImage]
    let title: [String]
}
