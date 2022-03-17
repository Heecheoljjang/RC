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
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var tempSign: UILabel!
    @IBOutlet weak var dustView: UIView!
    @IBOutlet weak var yesterdayView: UIView!
    @IBOutlet weak var eightView: UIView!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    var tempLat: Double?
    var tempLong: Double?
    
    var tempWeatherResponse: WeatherResponse?
    var tempAddressResponse: AddressResponse?
    var tempYesterdayResponse: YesterdayResponse?
    var tempAirPollutionResponse: AirPollutionResponse?

    
    var tableViewCell: MainTableViewCell?
    
    var currentStatus: Int = 1
    var isForecastBtnTapped: Bool = false
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        dismissIndicator()
        
        dustView.layer.cornerRadius = 10
        yesterdayView.layer.cornerRadius = 10
        eightView.layer.cornerRadius = 10
        
        feelsLikeLabel.isHidden = true
        
        prepareAnimation()
        
        

    }
    
    
    //MARK: 초기 화면 설정
    
    //이때는 weatherResponse가 들어와있음.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showAnimation()
        //받은 데이터 옵셔널 풀어줌
        guard let weatherResponse = tempWeatherResponse else { return }
        guard let addressResponse = tempAddressResponse else { return }
        guard let yesterdayResponse = tempYesterdayResponse else { return }
        guard let airPollutionResponse = tempAirPollutionResponse else { return }
        
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
        
        //MARK: 미세미세
        
        if airPollutionResponse.list[0].main.aqi == 5 { //매우 나쁨
            airPollutionImage.image = UIImage(systemName: "arrow.down")
            airPollutionLabel.text = "매우 나쁨"
            airPollutionImage.tintColor = .red
        } else if airPollutionResponse.list[0].main.aqi == 4 {
            airPollutionImage.image = UIImage(systemName: "arrow.down.right")
            airPollutionLabel.text = "나쁨"
            airPollutionImage.tintColor = .orange
        } else if airPollutionResponse.list[0].main.aqi == 3 {
            airPollutionImage.image = UIImage(systemName: "arrow.right")
            airPollutionLabel.text = "보통"
            airPollutionImage.tintColor = .green

        } else if airPollutionResponse.list[0].main.aqi == 2 {
            airPollutionImage.image = UIImage(systemName: "arrow.up.right")
            airPollutionLabel.text = "좋음"
            airPollutionImage.tintColor = .systemTeal

        } else  {
            airPollutionImage.image = UIImage(systemName: "arrow.up")
            airPollutionLabel.text = "매우 좋음"
            airPollutionImage.tintColor = .link

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // 이미지 애니메이션
    private func prepareAnimation() {
        mainImg.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    private func showAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.mainImg.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @IBAction func tapAirPollution(_ sender: Any) {
        
        guard let addressData = tempAddressResponse else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "Air") as? AirPollutionViewController else { return }
        vc.tempAirPollutionData = tempAirPollutionResponse
        vc.tempLocation = addressData.documents[0].region_2depth_name + " " + addressData.documents[0].region_3depth_name
        
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
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
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
        
        //온도
        if currentStatus == 1 || currentStatus == 2 {
            
            rightConstraint.constant = 23
            leftLabel.isHidden = false
            cell.tableViewMax.isHidden = false
            cell.tableViewMin.isHidden = false
            cell.hiddenLabel.isHidden = true
            cell.hiddenImg.isHidden = true
            cell.tableViewImg.isHidden = false
            rightLabel.text = "최저"

            
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
        
        } else if currentStatus == 3 {
            //자외선
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "자외선"
            
            let uvi = Int(round(weatherResponse.daily[indexPath.row].uvi))
            if uvi <= 2 {
                cell.hiddenLabel.text = "(\(uvi))"
                cell.hiddenImg.image = UIImage(systemName: "sun.dust")

            } else if uvi >= 3 && uvi <= 5 {
                cell.hiddenLabel.text = "(\(uvi))"
                cell.hiddenImg.image = UIImage(systemName: "sun.dust.fill")

            } else {
                cell.hiddenLabel.text = "(\(uvi))"
                cell.hiddenImg.image = UIImage(systemName: "sun.dust.fill")

            }
        } else if currentStatus == 4 {
            //바람
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "바람"
            
            let wind = Int(round(weatherResponse.daily[indexPath.row].wind_speed))
            cell.hiddenLabel.text = "\(wind)m/s"
            cell.hiddenImg.image = UIImage(systemName: "wind")
            
        } else if currentStatus == 5 {
            //습도
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "습도"
            
            let humidity = weatherResponse.daily[indexPath.row].humidity
            if humidity < 60  {
                cell.hiddenLabel.text = "\(humidity)%"
                cell.hiddenImg.image = UIImage(systemName: "drop")

            } else {
                cell.hiddenLabel.text = "\(humidity)%"
                cell.hiddenImg.image = UIImage(systemName: "drop.fill")
            }
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
            
            //컬렉션뷰 애니메이션
            cell.todayImg.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, animations: {
                cell.todayImg.transform = CGAffineTransform.identity
            }, completion: nil)
            
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
            if currentStatus == 1 {
                cell.detailLabel.isHidden = true

                if let temp = tempWeatherResponse?.hourly[indexPath.row].temp {
                    cell.tempLabel.text = "\(Int(round(temp - 273.15)))°"
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
                }
            } else if currentStatus == 2{ //체감온도
                cell.detailLabel.isHidden = true

                if let temp = tempWeatherResponse?.hourly[indexPath.row].feels_like {
                    cell.tempLabel.text = "\(Int(round(temp - 273.15)))°"
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
                }
            } else if currentStatus == 3 { //자외선
                cell.detailLabel.isHidden = false
                if let uvi = tempWeatherResponse?.hourly[indexPath.row].uvi {
                    cell.detailLabel.text = "\(Int(round(uvi)))"
                    
                    if uvi <= 2 {
                        cell.tempLabel.text = "낮음"
                        cell.todayImg.image = UIImage(systemName: "sun.dust")

                    } else if uvi >= 3 && uvi <= 5 {
                        cell.tempLabel.text = "보통"
                        cell.todayImg.image = UIImage(systemName: "sun.dust.fill")

                    } else {
                        cell.tempLabel.text = "높음"
                        cell.todayImg.image = UIImage(systemName: "sun.dust.fill")

                    }
                }
            } else if currentStatus == 4 { //바람
                cell.detailLabel.isHidden = false
                if let wind = tempWeatherResponse?.hourly[indexPath.row].wind_speed {
                    cell.detailLabel.text = "\(round(wind * 10) / 10)m/s"
                    
                    if wind < 1 {
                        cell.tempLabel.text = "없음"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    } else if wind >= 1 && wind <= 15 {
                        cell.tempLabel.text = "약함"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    } else {
                        cell.tempLabel.text = "강함"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    }
                }
            } else if currentStatus == 5 { //습도
                cell.detailLabel.isHidden = true
                if let humidity = tempWeatherResponse?.hourly[indexPath.row].humidity {
                    cell.detailLabel.text = "\(humidity)%"
                    
                    if humidity < 30 {
                        cell.tempLabel.text = "\(humidity)%"
                        cell.todayImg.image = UIImage(systemName: "drop")

                    } else if humidity >= 30 && humidity <= 60 {
                        cell.tempLabel.text = "\(humidity)%"
                        cell.todayImg.image = UIImage(systemName: "drop")

                    } else {
                        cell.tempLabel.text = "\(humidity)%"
                        cell.todayImg.image = UIImage(systemName: "drop.fill")

                    }
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
            
            if indexPath.row == 0 {
                cell.isUserInteractionEnabled = false
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

        if collectionView == bottomCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as? BottomCollectionViewCell else { return }

            if indexPath.row == 1{ //온도 선택
                
                
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                prepareAnimation()
                showAnimation()
                
                currentStatus = 1
                feelsLikeLabel.isHidden = true
                tempSign.isHidden = false
                currentMaxMinLabel.isHidden = false

                
                let yesterdayCompared = Int(round(weatherResponse.current.temp - 273.15)) - Int(round(yesterdayResponse.current.temp - 273.15))
                
                //초기 라벨 설정
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
                todayCollectionView.reloadData()
                dailyTableView.reloadData()
                
            } else if indexPath.row == 2 {
                
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                prepareAnimation()
                showAnimation()
                
                currentStatus = 2
                feelsLikeLabel.isHidden = false
                tempSign.isHidden = false
                currentMaxMinLabel.isHidden = false

                
                let yesterdayCompared = Int(round(weatherResponse.current.feels_like - 273.15)) - Int(round(yesterdayResponse.current.feels_like - 273.15))
                
                //초기 라벨 설정
                currentTempLabel.text = "\(Int(round(weatherResponse.current.feels_like - 273.15)))"
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
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()


            } else if indexPath.row == 3 { //자외선
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "자외선"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 3
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentUvi = Int(round(weatherResponse.current.uvi))
                //초기 라벨 설정
                if currentUvi < 2 {
                    mainImg.image = UIImage(systemName: "sun.dust")
                    currentTempLabel.text = "낮음"
                    yesterdayLabel.text = "자외선 수치 : \(currentUvi)"
                } else if currentUvi >= 2 && currentUvi <= 5 {
                    mainImg.image = UIImage(systemName: "sun.dust.fill")
                    currentTempLabel.text = "보통"
                    yesterdayLabel.text = "자외선 수치 : \(currentUvi)"

                } else if currentUvi > 5 {
                    mainImg.image = UIImage(systemName: "sun.dust.fill")
                    currentTempLabel.text = "높음"
                    yesterdayLabel.text = "자외선 수치 : \(currentUvi)"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()

                
            } else if indexPath.row == 4 {
                
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "바람"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 4
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentWind = round(weatherResponse.current.wind_speed * 10) / 10
                //초기 라벨 설정
                if currentWind < 1 {
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "없음"
                    yesterdayLabel.text = "바람 : \(currentWind)m/s"
                } else if currentWind >= 1 && currentWind <= 10 {
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "약함"
                    yesterdayLabel.text = "바람 : \(currentWind)m/s"

                } else if currentWind > 10{
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "강함"
                    yesterdayLabel.text = "바람 : \(currentWind)m/s"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()


            } else if indexPath.row == 5 {
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "습도"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 5
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentHumidity = weatherResponse.current.humidity
                //초기 라벨 설정
                if currentHumidity < 30 {
                    mainImg.image = UIImage(systemName: "drop")
                    currentTempLabel.text = "낮음"
                    yesterdayLabel.text = "습도: \(currentHumidity)%"
                } else if currentHumidity >= 30 && currentHumidity <= 60 {
                    mainImg.image = UIImage(systemName: "drop")
                    currentTempLabel.text = "보통"
                    yesterdayLabel.text = "습도: \(currentHumidity)%"

                } else if currentHumidity > 60{
                    mainImg.image = UIImage(systemName: "drop.fill")
                    currentTempLabel.text = "높음"
                    yesterdayLabel.text = "습도: \(currentHumidity)%"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()
            }
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
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var hiddenImg: UIImageView!
    @IBOutlet weak var hiddenLabel: UILabel!
    
}

// 콜렉션뷰 셀

class TodayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todayImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
}

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
        
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
