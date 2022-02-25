//
//  AroundViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/22.
//

import UIKit
import Tabman
import Pageboy

// MARK: 내 근처 뷰 컨트롤러
class AroundViewController: UIViewController {

    
    @IBOutlet weak var aroundCollectionView: UICollectionView!
    @IBOutlet weak var miniCollectionView: UICollectionView!
 
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var lastView: UIView!
    
    
    
    var collectionViewText: [String] = ["전세", "헬스", "필라테스", "이사", "투룸", "친구", "pt", "헬스장", "원룸", "벤리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        serviceView.layer.borderWidth = 1
        serviceView.layer.borderColor = UIColor.systemGray5.cgColor
        serviceView.layer.cornerRadius = 3
        lastView.layer.cornerRadius = 3
        
        //첫번째 컬렉션뷰
        let collectionViewXib = UINib(nibName: "AroundCollectionViewCell", bundle: nil)
        
        self.aroundCollectionView.register(collectionViewXib, forCellWithReuseIdentifier: "cell")
        
        //두번째 컬렉션뷰
        let miniCollectionViewXib = UINib(nibName: "MiniCollectionViewCell", bundle: nil)
        self.miniCollectionView.register(miniCollectionViewXib, forCellWithReuseIdentifier: "cell")
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
}

extension AroundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aroundCollectionView {
            return collectionViewText.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == aroundCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AroundCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.row == 0 {
                cell.outerView.layer.borderWidth = 0
                cell.bodyText.textColor = .gray
            } else {
                cell.outerView.layer.borderWidth = 1
                cell.outerView.layer.borderColor = UIColor.systemGray5.cgColor
                cell.outerView.layer.cornerRadius = 15
                cell.bodyText.text = collectionViewText[indexPath.row]
            }
            return cell
            
        } else  {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MiniCollectionViewCell else { return UICollectionViewCell() }
            
            
            return cell
        }
    }
}

//CollectionView
extension AroundViewController: UICollectionViewDelegate {
    
}

extension AroundViewController: UICollectionViewDelegateFlowLayout {
    
}



class AroundCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var bodyText: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


// MARK: 내 근처 컨테이너 뷰 컨트롤러
class AroundContainerViewController: TabmanViewController {
    
    var viewControllers: [UIViewController] = []
    var barTitle: [String] = ["동네 맛집", "겨울 간식"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        guard let foodVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "food") as? FoodViewController else { return }
        guard let winterVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "winter") as? WinterViewController else { return }
        
        viewControllers.append(foodVC)
        viewControllers.append(winterVC)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        bar.buttons.customize { (button) in
            button.tintColor = .darkGray
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 14)
        }
        bar.indicator.tintColor = .black
        bar.indicator.weight = .light
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        bar.backgroundView.style = .clear
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension AroundContainerViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = barTitle[index]

        return item
    }
    
}

// MARK: FOOD VC
class FoodViewController: UIViewController {
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var moreView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewXib = UINib(nibName: "FoodTableViewCell", bundle: nil)
        
        self.foodTableView.register(tableViewXib, forCellReuseIdentifier: "cell")
        
        moreView.layer.borderWidth = 1
        moreView.layer.borderColor = UIColor.systemGray5.cgColor
        moreView.layer.cornerRadius = 3
        
        hideTableViewLastSeparator()
    }
    func hideTableViewLastSeparator() {
        let footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
      
        foodTableView.tableFooterView = footerView
    }
}

extension FoodViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FoodTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

class FoodTableViewCell: UITableViewCell {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: Winter VC
class WinterViewController: UIViewController {
    
    @IBOutlet weak var winterTableView: UITableView!
    @IBOutlet weak var moreView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewXib = UINib(nibName: "WinterTableViewCell", bundle: nil)
        
        self.winterTableView.register(tableViewXib, forCellReuseIdentifier: "cell")
        
        moreView.layer.borderWidth = 1
        moreView.layer.borderColor = UIColor.systemGray5.cgColor
        moreView.layer.cornerRadius = 3
        
    }
}
extension WinterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WinterTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

class WinterTableViewCell: UITableViewCell {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: 당근 미니 컬렉션뷰 cell

class MiniCollectionViewCell: UICollectionViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}


