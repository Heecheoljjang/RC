//
//  MainViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/06.
//

import UIKit
import Alamofire
import Foundation

class MainViewController: UIViewController{
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMaxMinLabel: UILabel!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var airPollutionImage: UIImageView!
    @IBOutlet weak var airPollutionLabel: UILabel!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var forecastLabel: UILabel!
    
    var tempLat: Double?
    var tempLong: Double?
    
    var tempWeatherResponse: WeatherResponse?
    var tempAddressResponse: AddressResponse?
    var tempAirPollutionResponse: AirPollutionResponse?
    var tempYesterdayResponse: YesterdayResponse?
    
    var currentStatus: Int = 1
    var isForecastBtnTapped: Bool = false
            
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
        //guard let airPollutionResponse = tempAirPollutionResponse else { return }
        
        //print("날씨정보: \(weatherResponse)")
        
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
        
        //시간 계산
        
        let hourlyTime = weatherResponse.current.dt
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
            
        
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
            if hour <= 6 || hour >= 19 {
                mainImg.image = UIImage(systemName: "moon.fill")
                todayWeatherLabel.text = "맑음"
            } else {
                mainImg.image = UIImage(systemName: "sun.max.fill")
                todayWeatherLabel.text = "맑음"
            }
        } else if weatherResponse.current.weather[0].id == 801 {
            //해가 지지 않은 경ㅇ
            if hour <= 6 || hour >= 19 {
                mainImg.image = UIImage(systemName: "cloud.moon.fill")
                todayWeatherLabel.text = "대체로 맑음"
            } else {
                mainImg.image = UIImage(systemName: "cloud.sun.fill")
                todayWeatherLabel.text = "대체로 맑음"
            }
        } else {
            mainImg.image = UIImage(systemName: "cloud.fill")
            todayWeatherLabel.text = "흐림"
        }
        
//        if airPollitionResponse.list[0].main.aqi == 1 {
//            airPollutionLabel.text = "매우 좋음"
//            airPollutionImage.image = UIImage(systemName: "")
//
//        } else if airPollitionResponse.list[0].main.aqi == 2 {
//
//        } else if airPollitionResponse.list[0].main.aqi == 3 {
//
//        } else if airPollitionResponse.list[0].main.aqi == 4 {
//
//        } else {
//
//        }
        
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
    @IBAction func tapForecast(_ sender: Any) {
        
        if isForecastBtnTapped == false {
            scrollViewHeight.constant += 150
            tableViewHeight.constant += 150
            isForecastBtnTapped = true
            forecastLabel.text = "8일 예보 닫기"
        } else {
            scrollViewHeight.constant -= 150
            tableViewHeight.constant -= 150
            isForecastBtnTapped = false
            forecastLabel.text = "8일 예보 보기"

        }
        
    }
}
// MARK: 테이블뷰

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let weatherResponse = tempWeatherResponse else { return 0 }
        
        
        return weatherResponse.daily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        guard let weatherResponse = tempWeatherResponse else { return UITableViewCell() }
        
        let dailyTime = weatherResponse.daily[indexPath.row].dt
        let date = Date(timeIntervalSince1970: TimeInterval(dailyTime))
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if weekday == 1 {
            cell.weekdayLabel.text = "일"
        } else if weekday == 2 {
            cell.weekdayLabel.text = "월"
        } else if weekday == 3 {
            cell.weekdayLabel.text = "화"
        } else if weekday == 4 {
            cell.weekdayLabel.text = "수"
        } else if weekday == 5 {
            cell.weekdayLabel.text = "목"
        } else if weekday == 6 {
            cell.weekdayLabel.text = "금"
        } else {
            cell.weekdayLabel.text = "토"
        }
        
        if indexPath.row == 0 {
            cell.dateLabel.text = "오늘"
        } else if indexPath.row == 1 {
            cell.dateLabel.text = "내일"
        } else if indexPath.row == 2 {
            cell.dateLabel.text = "모레"
        } else {
            cell.dateLabel.text = "\(month).\(day)"
        }
        
        
        
        cell.tableViewMax.text = "\(Int(round(weatherResponse.daily[indexPath.row].temp.max - 273.15)))°"
        cell.tableViewMin.text = "\(Int(round(weatherResponse.daily[indexPath.row].temp.min - 273.15)))°"
        
        if weatherResponse.daily[indexPath.row].weather[0].id >= 200 && weatherResponse.daily[indexPath.row].weather[0].id <= 299 {
            cell.tableViewImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
        } else if weatherResponse.daily[indexPath.row].weather[0].id >= 300 && weatherResponse.daily[indexPath.row].weather[0].id <= 599 {
            cell.tableViewImg.image = UIImage(systemName: "cloud.rain.fill")
        } else if weatherResponse.daily[indexPath.row].weather[0].id >= 600 && weatherResponse.daily[indexPath.row].weather[0].id <= 699 {
            cell.tableViewImg.image = UIImage(systemName: "snow")
        } else if weatherResponse.daily[indexPath.row].weather[0].id >= 700 && weatherResponse.daily[indexPath.row].weather[0].id <= 799 {
            cell.tableViewImg.image = UIImage(systemName: "cloud.fog.fill")
        } else if weatherResponse.daily[indexPath.row].weather[0].id == 800 {
            cell.tableViewImg.image = UIImage(systemName: "sun.max.fill")
        } else if weatherResponse.daily[indexPath.row].weather[0].id == 801 {
            cell.tableViewImg.image = UIImage(systemName: "cloud.sun.fill")
        } else {
            cell.tableViewImg.image = UIImage(systemName: "cloud.fill")
        }
    
        return cell
    }
}


// MARK: 콜렉션뷰
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
            
            if let hourlyTime = tempWeatherResponse?.hourly[indexPath.row].dt {
                let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)

                //시간
                if hour > 0 && hour <= 11 {
                    cell.timeLabel.text = "오전 \(hour)시"
                } else if hour == 12 {
                    cell.timeLabel.text = "오후 \(hour)시"
                } else if hour == 0 {
                    cell.timeLabel.text = "오전 12시"
                } else {
                    cell.timeLabel.text = "오후 \(hour - 12)시"
                }
                
            }
            
            // 현재 온도
            if let temp = tempWeatherResponse?.hourly[indexPath.row].temp {
                cell.tempLabel.text = "\(Int(round(temp - 273.15)))°"
            }
            // 이미지
            if let weather = tempWeatherResponse?.hourly[indexPath.row].weather[0].id, let hourlyTime = tempWeatherResponse?.hourly[indexPath.row].dt {
                
                let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                
                if weather >= 200 && weather <= 299 {
                    cell.todayImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
                } else if weather >= 300 && weather <= 599 {
                    cell.todayImg.image = UIImage(systemName: "cloud.rain.fill")
                } else if weather >= 600 && weather <= 699 {
                    cell.todayImg.image = UIImage(systemName: "snow")
                } else if weather >= 700 && weather <= 799 {
                    cell.todayImg.image = UIImage(systemName: "cloud.fog.fill")
                } else if weather == 800 {
                    // 저녁 7시부터 오전 6시까지 달 모양
                    if hour <= 6 || hour >= 19 {
                        cell.todayImg.image = UIImage(systemName: "moon.fill")
                    } else { //오후
                        cell.todayImg.image = UIImage(systemName: "sun.max.fill")
                    }
                } else if weather == 801 {
                    // 저녁 7시부터 오전 6시까지 달 모양
                    if hour <= 6 || hour >= 19 {
                        cell.todayImg.image = UIImage(systemName: "cloud.moon.fill")
                    } else { //오후
                        cell.todayImg.image = UIImage(systemName: "cloud.sun.fill")
                    }
                } else {
                    cell.todayImg.image = UIImage(systemName: "cloud.fill")
                }
            }
            
            return cell
            
            
        //bottom 콜렉션 뷰
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as? BottomCollectionViewCell else { return UICollectionViewCell() }
                        
            if indexPath.row == 1 {
                collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
                cell.isSelected = true
            }
            
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as? BottomCollectionViewCell else { return }
        guard let tableCell = dailyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else { return }

        if indexPath.row == 3 {
            mainImg.image = UIImage(systemName: "sun.max.fill")
            tableCell.tableViewImg.image = UIImage(systemName: "sun.max.fill")
            cell.backgroundColor = .red
            dailyTableView.reloadData()
        }

    }
    
}

//테이블뷰 셀

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var tableViewImg: UIImageView!
    @IBOutlet weak var tableViewMax: UILabel!
    @IBOutlet weak var tableViewMin: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
}

// 콜렉션뷰 셀

class TodayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todayImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
        
}

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    var currentStatus: Int = 1
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            backgroundColor = UIColor(named: "nightColor")
            label.textColor = .white
        } else {
            backgroundColor = UIColor.white
            label.textColor = UIColor(named: "nightColor")
        }
      }
    }
}
