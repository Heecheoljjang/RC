//
//  LifeViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/21.
//

import UIKit

class LifeViewController: UIViewController {

    
    let labelText: [String] = ["동네질문", "동네맛집", "동네사건사고", "해주세요", "취미생활", "강아지", "고양이", "동네소식", "일상", "분실/실종센터"]
    var lifeTableViewCellInfo: [LifeTableStruct] = []
    
    @IBOutlet weak var lifeTableView: UITableView!
    
    let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemOrange
        
        let image = UIImage(systemName: "pencil",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold) )
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        button.layer.shadowRadius = 45
        button.layer.shadowOpacity = 1
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네질문", body: "강아지 의상 사려고 하는데, 다들 어디서 사시나요?(오프라인) 홍대, 명동 서울내라면 어디든 상관없느데 ㅎㅎ강아지 의상 사려고 하는데, 다들 어디서 사시나요?(오프라인) 홍대, 명동 서울내라면 어디든 상관없느데 ㅎㅎ강아지 의상 사려고 하는데, 다들 어디서 사시나요?(오프라인) 홍대, 명동 서울내라면 어디든 상관없느데 ㅎㅎ", name: "kims", location: "1동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네맛집", body: "라멘 맛있는 집 추천해주세요.", name: "희철", location: "23동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네소식", body: "오늘 동네에 방탄소년단이 왔어요", name: "뷔", location: "1123동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "취미생활", body: "같이 운동할 분 구해요.같이 운동할 분 구해요.같이 운동할 분 구해요.같이 운동할 분 구해요.같이 운동할 분 구해요.같이 운동할 분 구해요.", name: "우사인볼트", location: "동동동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네소식", body: "동네에 우사인볼트가 왔어요", name: "윤희철", location: "115동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "분실/실종센터", body: "108동 고양이 좀 찾아주세요. 하얗고 귀엽습니다. 얼굴에 점이 있어요..ㅠㅠㅠ", name: "캣맘", location: "가나다라동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네사건사고", body: "동동동에서 일어난 교통사고 목격자를 찾습니다.", name: "경찰", location: "경찰동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네질문", body: "이 동네에 가방은 어디서 사면 되나요? 여행가는데 캐리어가 필요합니다.", name: "대한항공", location: "비행기동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네질문", body: "다음 대통령은 누구입니까?", name: "모름", location: "여의도동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네소식", body: "가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사", name: "가나", location: "ㅇㄴㄹㅁㄴㅇㄹ동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "동네맛집", body: "ddfdfdfdsfdsfsd", name: "dfdf", location: "dkdkd동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "일상", body: "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세 무궁화 삼천리 화려강ㅅ나   ", name: "하느님", location: "백두산동"))
        lifeTableViewCellInfo.append(LifeTableStruct(category: "해주세요", body: "바퀴벌레 잡아주세요.", name: "매미", location: "수동"))
        
        let myTableViewCellXib = UINib(nibName: "LifeTableViewCell", bundle: nil)
        
        self.lifeTableView.register(myTableViewCellXib, forCellReuseIdentifier: "cell")

        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
    }
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        floatingButton.frame = CGRect(x: view.frame.size.width - 50 - 17,
                                      y: view.frame.size.height - 50 - 10 - 80,
                                      width: 50,
                                      height: 50)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lifeTableView.reloadData()
    }
    @objc func didTapBtn() {
        let sb = UIStoryboard(name: "AddLifeContent", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "AddLifeContent") as? AddLifeContentViewController else { return }
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension LifeViewController: SendLifeTableDataDelegate {
    func sendData(data: LifeTableStruct) {
        lifeTableViewCellInfo.insert(data, at: 0)
    }
}


// MARK: 컬렉션뷰(카테고리)
extension LifeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelText.count
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
        return lifeTableViewCellInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LifeTableViewCell else { return UITableViewCell() }
    
        cell.category.text = lifeTableViewCellInfo[indexPath.row].category
        cell.bodyText.text = lifeTableViewCellInfo[indexPath.row].body
        cell.name.text = lifeTableViewCellInfo[indexPath.row].name
        cell.location.text = lifeTableViewCellInfo[indexPath.row].location
        
        return cell
    }
}

extension LifeViewController: UITableViewDelegate {
    
}

class LifeTableViewCell: UITableViewCell {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

struct LifeTableStruct {
    var category: String
    var body: String
    var name: String
    var location: String
}
