//
//  SearchViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/25.
//

import UIKit

class SearchViewController: UIViewController {

    var backBtnImage = UIImage(systemName: "arrow.left")
    var categories: [String] = ["투룸", "필라테스", "친구", "헬스", "이사", "전세", "헬스장", "과외"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //네비게이션 바 back버튼 커스텀
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backIndicatorImage = backBtnImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backBtnImage
        
        self.navigationController?.navigationBar.isHidden = false

    }
}
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.labelView.layer.borderWidth = 1
        cell.labelView.layer.borderColor = UIColor.systemGray5.cgColor
        cell.labelView.layer.cornerRadius = 15
        cell.categoryLabel.text = categories[indexPath.row]
        
        return cell
    }
    
}
extension SearchViewController: UICollectionViewDelegate {
    
}

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
}
