//
//  LifeViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/21.
//

import UIKit

class LifeViewController: UIViewController {

    let labelText: [String] = ["동네질문", "동네맛집", "동네소식", "취미생활취미생활", "동네질문", "동네질문", "동네질문", "동네질문", "동네질문", "동네질문"]
    
    let bodyText: [String] = [
        "윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철윤희철", "아아아아아아아아아아아아아아앙아ㅏㅇ아아", "투투투투투투투투투퉅투투투투퉅투ㅜㅌ투투투투투투투투투투투퉅", "기기기기기기기기기기", "니니니니니니닌니니니", "알어날ㅇ널", "안녕아헤숑", "반가워여", "희희희흐히ㅡ히ㅡ히ㅡ히", "코코쿄ㅗ쿄ㅕ켜ㅛ쿄쿄쿄쿄쿄쿄쿄쿜쿄쿄쿄쿄쿄쿄"
    ]
    
    @IBOutlet weak var lifeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myTableViewCellXib = UINib(nibName: "LifeCollectionViewCell", bundle: nil)
        
        self.lifeTableView.register(myTableViewCellXib, forCellReuseIdentifier: "cell")

    }
    
}


// MARK: 컬렉션뷰
extension LifeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LifeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.labelText.text = labelText[indexPath.row]
        
        return cell
    }
}

extension LifeViewController: UICollectionViewDelegate {
    
}

class LifeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelText: UILabel!
    
}

//MARK: 테이블 뷰
extension LifeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LifeTableViewCell else { return UITableViewCell() }
    
        cell.bodyText.text = bodyText[indexPath.row]
        
        return cell
    }
}

extension LifeViewController: UITableViewDelegate {
    
}

class LifeTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
