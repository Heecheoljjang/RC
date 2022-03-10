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
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMaxMinLabel: UILabel!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var airPollutionImage: UIImageView!
    @IBOutlet weak var airPollutionLabel: UILabel!
    
    var tempLat: Double?
    var tempLong: Double?
    
    var tempWeatherResponse: WeatherResponse?
    var tempAddressResponse: AddressResponse?
    var tempAirPollutionResponse: AirPollutionResponse?
    var tempYesterdayResponse: YesterdayResponse?
    
    var currentStatus: Int = 1
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareAnimation()

    }
    
    
    //MARK: 초기 화면 설정
    
    //이때는 weatherResponse가 들어와있음.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //받은 데이터 옵셔널 풀어줌
        guard let weatherResponse = tempWeatherResponse else { return }
        guard let addressResponse = tempAddressResponse else { return }
        guard let yesterdayResponse = tempYesterdayResponse else { return }
        guard let airPollitionResponse = tempAirPollutionResponse else { return }
        
        //현재온도 - 과거온도
        let yesterdayCompared = Int(round(weatherResponse.current.temp - 273.15)) - Int(round(yesterdayResponse.current.temp - 273.15))
        
        //초기 라벨 설정
        locationLabel.text = addressResponse.documents[0].region_2depth_name + " " + addressResponse.documents[0].region_3depth_name
        currentTempLabel.text = "\(Int(round(weatherResponse.current.temp - 273.15)))"
        currentMaxMinLabel.text = "최고 \(Int(round(weatherResponse.daily[0].temp.max - 273.15)))°/ 최저 \(Int(round(weatherResponse.daily[0].temp.min - 273.15)))°"
        if yesterdayCompared < 0 {
            yesterdayLabel.text = "어제보다 \(abs(yesterdayCompared))° 낮아요"
        } else if yesterdayCompared == 0 {
            yesterdayLabel.text = "어제랑 똑같아요"
        } else {
            yesterdayLabel.text = "어제보다 \(abs(yesterdayCompared))° 높아요"
        }
        
        
        if weatherResponse.current.weather[0].id >= 200 && weatherResponse.current.weather[0].id <= 299 {
            mainImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
            todayWeatherLabel.text = "뇌우"
        } else if weatherResponse.current.weather[0].id >= 300 && weatherResponse.current.weather[0].id <= 599 {
            mainImg.image = UIImage(systemName: "cloud.rain.fill")
            todayWeatherLabel.text = "비"
        } else if weatherResponse.current.weather[0].id >= 600 && weatherResponse.current.weather[0].id <= 699 {
            mainImg.image = UIImage(systemName: "snow")
            todayWeatherLabel.text = "눈"
        } else if weatherResponse.current.weather[0].id >= 700 && weatherResponse.current.weather[0].id <= 799 {
            mainImg.image = UIImage(systemName: "cloud.fog.fill")
            todayWeatherLabel.text = "안개"
        } else if weatherResponse.current.weather[0].id == 800 {
            //아직 해가 지지 않은 경우
            if weatherResponse.current.dt <= weatherResponse.current.sunset {
                mainImg.image = UIImage(systemName: "sun.max.fill")
                todayWeatherLabel.text = "맑음"
            } else {
                mainImg.image = UIImage(systemName: "moon.fill")
                todayWeatherLabel.text = "맑음"
            }
        } else if weatherResponse.current.weather[0].id == 801 {
            //해가 지지 않은 경ㅇ
            if weatherResponse.current.dt <= weatherResponse.current.sunset {
                mainImg.image = UIImage(systemName: "cloud.sun.fill")
                todayWeatherLabel.text = "대체로 맑음"
            } else {
                mainImg.image = UIImage(systemName: "cloud.moon.fill")
                todayWeatherLabel.text = "대체로 맑음"
            }
        } else {
            mainImg.image = UIImage(systemName: "cloud.fill")
            todayWeatherLabel.text = "흐림"
        }
        
        if airPollitionResponse.list[0].main.aqi == 1 {
            airPollutionLabel.text = "매우 좋음"
            airPollutionImage.image = UIImage(systemName: "")
            
        } else if airPollitionResponse.list[0].main.aqi == 2 {
            
        } else if airPollitionResponse.list[0].main.aqi == 3 {
            
        } else if airPollitionResponse.list[0].main.aqi == 4 {
            
        } else {
            
        }
        
        //today컬렉션뷰 리로드
        todayCollectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAnimation()
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
        //AirPollutionRequest().getAirPollutionData(lat: myLat, long: myLong, viewcontroller: vc)
        
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
            
            guard let weatherResponse = tempWeatherResponse else { return 0}
            
            return weatherResponse.hourly.count

        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == todayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }
            
            if let temp = tempWeatherResponse?.hourly[indexPath.row].temp {
                cell.tempLabel.text = "\(Int(temp - 273.15))°"
            }
            if let weather = tempWeatherResponse?.hourly[indexPath.row].weather[0].id {
                if weather >= 200 && weather <= 299 {
                    cell.todayImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
                } else if weather >= 300 && weather <= 599 {
                    cell.todayImg.image = UIImage(systemName: "cloud.rain.fill")
                } else if weather >= 600 && weather <= 699 {
                    cell.todayImg.image = UIImage(systemName: "snow")
                } else if weather >= 700 && weather <= 799 {
                    cell.todayImg.image = UIImage(systemName: "cloud.fog.fill")
                } else if weather == 800 {
                    cell.todayImg.image = UIImage(systemName: "sun.max.fill")
                } else if weather == 801 {
                    cell.todayImg.image = UIImage(systemName: "cloud.sun.fill")
                } else {
                    cell.todayImg.image = UIImage(systemName: "cloud.fill")
                }
            }
            
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
    
    @IBOutlet weak var todayImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
        
}

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
}
