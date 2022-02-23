//
//  AroundViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/22.
//

import UIKit

class AroundViewController: UIViewController {

    
    @IBOutlet weak var aroundCollectionView: UICollectionView!
    
    var collectionViewText: [String] = ["전세", "헬스", "필라테스", "이사", "투룸", "친구", "pt", "헬스장", "원룸", "벤리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewXib = UINib(nibName: "AroundCollectionViewCell", bundle: nil)
        
        self.aroundCollectionView.register(collectionViewXib, forCellWithReuseIdentifier: "cell")
        
    }
    
    

}

extension AroundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
}

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
