//
//  MainViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/06.
//

import UIKit
import Alamofire

class MainViewController: UIViewController{
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    
    var tempLat: Double?
    var tempLong: Double?
    
    var currentStatus: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareAnimation()
        
        guard let myLat = tempLat else { return }
        guard let myLong = tempLong else { return }
        
        AddressRequest().getAddressData(lat: myLat, long: myLong, viewcontroller: self)
        WeatherRequest().getWeatherData(lat: myLat, lon: myLong, viewController: self)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAnimation()
    }
    
    func setLocationLabel(_ response: AddressResponse) {
        locationLabel.text = response.documents[0].region_2depth_name + " " + response.documents[0].region_3depth_name
    }
    
    // 이미지 애니메이션
    private func prepareAnimation() {
        mainImg.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    private func showAnimation() {
        UIView.animate(withDuration: 0.8, animations: {
            self.mainImg.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @IBAction func tapAirPollution(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "Air") as? AirPollutionViewController else { return }
        guard let myLat = tempLat else { return }
        guard let myLong = tempLong else { return }
        AirPollutionRequest().getAirPollutionData(lat: myLat, long: myLong, viewcontroller: vc)
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == todayCollectionView {
            return 10

        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == todayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as? BottomCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            
            if indexPath.row == 1 {
                cell.label.text = "온도"
            } else if indexPath.row == 2{
                cell.label.text = "체감"
            } else if indexPath.row == 3{
                cell.label.text = "자외선"
            } else if indexPath.row == 4{
                cell.label.text = "바람"
            } else if indexPath.row == 5{
                cell.label.text = "습도"
            } else if indexPath.row == 0 {
                cell.layer.borderWidth = 0
                cell.layer.masksToBounds = false
                cell.label.isHidden = true
                let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
                imageView.image = UIImage(systemName: "arrow.down.right.and.arrow.up.left")
                imageView.tintColor = .black
                cell.contentView.addSubview(imageView)
            }
            return  cell
        }
        
    }
    
}

//테이블뷰 셀

class MainTableViewCell: UITableViewCell {
    
}

// 콜렉션뷰 셀

class TodayCollectionViewCell: UICollectionViewCell {
    
}

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
}
