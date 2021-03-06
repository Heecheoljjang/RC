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
    
    
    //MARK: ?????? ?????? ??????
    
    //????????? weatherResponse??? ???????????????.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showAnimation()
        //?????? ????????? ????????? ?????????
        guard let weatherResponse = tempWeatherResponse else { return }
        guard let addressResponse = tempAddressResponse else { return }
        guard let yesterdayResponse = tempYesterdayResponse else { return }
        guard let airPollutionResponse = tempAirPollutionResponse else { return }
        
        //print("????????????: \(weatherResponse)")
        
        //???????????? - ????????????
        let yesterdayCompared = Int(round(weatherResponse.current.temp - 273.15)) - Int(round(yesterdayResponse.current.temp - 273.15))
        
        //?????? ?????? ??????
        locationLabel.text = addressResponse.documents[0].region_2depth_name + " " + addressResponse.documents[0].region_3depth_name
        currentTempLabel.text = "\(Int(round(weatherResponse.current.temp - 273.15)))"
        currentMaxMinLabel.text = "?????? \(Int(round(weatherResponse.daily[0].temp.max - 273.15)))??/ ?????? \(Int(round(weatherResponse.daily[0].temp.min - 273.15)))??"
        if yesterdayCompared < 0 {
            yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
        } else if yesterdayCompared == 0 {
            yesterdayLabel.text = "????????? ????????????"
        } else {
            yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
        }
        
        //?????? ??????
        
        let hourlyTime = weatherResponse.current.dt
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
            
        
        if weatherResponse.current.weather[0].id >= 200 && weatherResponse.current.weather[0].id <= 299 {
            mainImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
            todayWeatherLabel.text = "??????"
        } else if weatherResponse.current.weather[0].id >= 300 && weatherResponse.current.weather[0].id <= 599 {
            mainImg.image = UIImage(systemName: "cloud.rain.fill")
            todayWeatherLabel.text = "???"
        } else if weatherResponse.current.weather[0].id >= 600 && weatherResponse.current.weather[0].id <= 699 {
            mainImg.image = UIImage(systemName: "snow")
            todayWeatherLabel.text = "???"
        } else if weatherResponse.current.weather[0].id >= 700 && weatherResponse.current.weather[0].id <= 799 {
            mainImg.image = UIImage(systemName: "cloud.fog.fill")
            todayWeatherLabel.text = "??????"
        } else if weatherResponse.current.weather[0].id == 800 {
            //?????? ?????? ?????? ?????? ??????
            if hour <= 6 || hour >= 19 {
                mainImg.image = UIImage(systemName: "moon.fill")
                todayWeatherLabel.text = "??????"
            } else {
                mainImg.image = UIImage(systemName: "sun.max.fill")
                todayWeatherLabel.text = "??????"
            }
        } else if weatherResponse.current.weather[0].id == 801 {
            //?????? ?????? ?????? ??????
            if hour <= 6 || hour >= 19 {
                mainImg.image = UIImage(systemName: "cloud.moon.fill")
                todayWeatherLabel.text = "????????? ??????"
            } else {
                mainImg.image = UIImage(systemName: "cloud.sun.fill")
                todayWeatherLabel.text = "????????? ??????"
            }
        } else {
            mainImg.image = UIImage(systemName: "cloud.fill")
            todayWeatherLabel.text = "??????"
        }
        
//        if airPollitionResponse.list[0].main.aqi == 1 {
//            airPollutionLabel.text = "?????? ??????"
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
        
        //today???????????? ?????????
        todayCollectionView.reloadData()
        
        //MARK: ????????????
        
        if airPollutionResponse.list[0].main.aqi == 5 { //?????? ??????
            airPollutionImage.image = UIImage(systemName: "arrow.down")
            airPollutionLabel.text = "?????? ??????"
            airPollutionImage.tintColor = .red
        } else if airPollutionResponse.list[0].main.aqi == 4 {
            airPollutionImage.image = UIImage(systemName: "arrow.down.right")
            airPollutionLabel.text = "??????"
            airPollutionImage.tintColor = .orange
        } else if airPollutionResponse.list[0].main.aqi == 3 {
            airPollutionImage.image = UIImage(systemName: "arrow.right")
            airPollutionLabel.text = "??????"
            airPollutionImage.tintColor = .green

        } else if airPollutionResponse.list[0].main.aqi == 2 {
            airPollutionImage.image = UIImage(systemName: "arrow.up.right")
            airPollutionLabel.text = "??????"
            airPollutionImage.tintColor = .systemTeal

        } else  {
            airPollutionImage.image = UIImage(systemName: "arrow.up")
            airPollutionLabel.text = "?????? ??????"
            airPollutionImage.tintColor = .link

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // ????????? ???????????????
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
            forecastLabel.text = "8??? ?????? ??????"
        } else {
            scrollViewHeight.constant -= 150
            tableViewHeight.constant -= 150
            isForecastBtnTapped = false
            forecastLabel.text = "8??? ?????? ??????"

        }
        
    }
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
}
// MARK: ????????????

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
            cell.weekdayLabel.text = "???"
        } else if weekday == 2 {
            cell.weekdayLabel.text = "???"
        } else if weekday == 3 {
            cell.weekdayLabel.text = "???"
        } else if weekday == 4 {
            cell.weekdayLabel.text = "???"
        } else if weekday == 5 {
            cell.weekdayLabel.text = "???"
        } else if weekday == 6 {
            cell.weekdayLabel.text = "???"
        } else {
            cell.weekdayLabel.text = "???"
        }
        
        if indexPath.row == 0 {
            cell.dateLabel.text = "??????"
        } else if indexPath.row == 1 {
            cell.dateLabel.text = "??????"
        } else if indexPath.row == 2 {
            cell.dateLabel.text = "??????"
        } else {
            cell.dateLabel.text = "\(month).\(day)"
        }
        
        //??????
        if currentStatus == 1 || currentStatus == 2 {
            
            rightConstraint.constant = 23
            leftLabel.isHidden = false
            cell.tableViewMax.isHidden = false
            cell.tableViewMin.isHidden = false
            cell.hiddenLabel.isHidden = true
            cell.hiddenImg.isHidden = true
            cell.tableViewImg.isHidden = false
            rightLabel.text = "??????"

            
            cell.tableViewMax.text = "\(Int(round(weatherResponse.daily[indexPath.row].temp.max - 273.15)))??"
            cell.tableViewMin.text = "\(Int(round(weatherResponse.daily[indexPath.row].temp.min - 273.15)))??"
            
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
            //?????????
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "?????????"
            
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
            //??????
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "??????"
            
            let wind = Int(round(weatherResponse.daily[indexPath.row].wind_speed))
            cell.hiddenLabel.text = "\(wind)m/s"
            cell.hiddenImg.image = UIImage(systemName: "wind")
            
        } else if currentStatus == 5 {
            //??????
            rightConstraint.constant = 50
            leftLabel.isHidden = true
            cell.tableViewMax.isHidden = true
            cell.tableViewMin.isHidden = true
            cell.hiddenLabel.isHidden = false
            cell.hiddenImg.isHidden = false
            cell.tableViewImg.isHidden = true
            rightLabel.text = "??????"
            
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


// MARK: ????????????
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
            
            //???????????? ???????????????
            cell.todayImg.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 1, animations: {
                cell.todayImg.transform = CGAffineTransform.identity
            }, completion: nil)
            
            if let hourlyTime = tempWeatherResponse?.hourly[indexPath.row].dt {
                let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)

                //??????
                if hour > 0 && hour <= 11 {
                    cell.timeLabel.text = "?????? \(hour)???"
                } else if hour == 12 {
                    cell.timeLabel.text = "?????? \(hour)???"
                } else if hour == 0 {
                    cell.timeLabel.text = "?????? 12???"
                } else {
                    cell.timeLabel.text = "?????? \(hour - 12)???"
                }
                
            }
            
            // ?????? ??????
            if currentStatus == 1 {
                cell.detailLabel.isHidden = true

                if let temp = tempWeatherResponse?.hourly[indexPath.row].temp {
                    cell.tempLabel.text = "\(Int(round(temp - 273.15)))??"
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
                            // ?????? 7????????? ?????? 6????????? ??? ??????
                            if hour <= 6 || hour >= 19 {
                                cell.todayImg.image = UIImage(systemName: "moon.fill")
                            } else { //??????
                                cell.todayImg.image = UIImage(systemName: "sun.max.fill")
                            }
                        } else if weather == 801 {
                            // ?????? 7????????? ?????? 6????????? ??? ??????
                            if hour <= 6 || hour >= 19 {
                                cell.todayImg.image = UIImage(systemName: "cloud.moon.fill")
                            } else { //??????
                                cell.todayImg.image = UIImage(systemName: "cloud.sun.fill")
                            }
                        } else {
                            cell.todayImg.image = UIImage(systemName: "cloud.fill")
                        }
                    }
                }
            } else if currentStatus == 2{ //????????????
                cell.detailLabel.isHidden = true

                if let temp = tempWeatherResponse?.hourly[indexPath.row].feels_like {
                    cell.tempLabel.text = "\(Int(round(temp - 273.15)))??"
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
                            // ?????? 7????????? ?????? 6????????? ??? ??????
                            if hour <= 6 || hour >= 19 {
                                cell.todayImg.image = UIImage(systemName: "moon.fill")
                            } else { //??????
                                cell.todayImg.image = UIImage(systemName: "sun.max.fill")
                            }
                        } else if weather == 801 {
                            // ?????? 7????????? ?????? 6????????? ??? ??????
                            if hour <= 6 || hour >= 19 {
                                cell.todayImg.image = UIImage(systemName: "cloud.moon.fill")
                            } else { //??????
                                cell.todayImg.image = UIImage(systemName: "cloud.sun.fill")
                            }
                        } else {
                            cell.todayImg.image = UIImage(systemName: "cloud.fill")
                        }
                    }
                }
            } else if currentStatus == 3 { //?????????
                cell.detailLabel.isHidden = false
                if let uvi = tempWeatherResponse?.hourly[indexPath.row].uvi {
                    cell.detailLabel.text = "\(Int(round(uvi)))"
                    
                    if uvi <= 2 {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "sun.dust")

                    } else if uvi >= 3 && uvi <= 5 {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "sun.dust.fill")

                    } else {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "sun.dust.fill")

                    }
                }
            } else if currentStatus == 4 { //??????
                cell.detailLabel.isHidden = false
                if let wind = tempWeatherResponse?.hourly[indexPath.row].wind_speed {
                    cell.detailLabel.text = "\(round(wind * 10) / 10)m/s"
                    
                    if wind < 1 {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    } else if wind >= 1 && wind <= 15 {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    } else {
                        cell.tempLabel.text = "??????"
                        cell.todayImg.image = UIImage(systemName: "wind")

                    }
                }
            } else if currentStatus == 5 { //??????
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
            
        //bottom ????????? ???
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
                cell.label.text = "??????"
            } else if indexPath.row == 2{
                cell.label.text = "??????"
            } else if indexPath.row == 3{
                cell.label.text = "?????????"
            } else if indexPath.row == 4{
                cell.label.text = "??????"
            } else if indexPath.row == 5{
                cell.label.text = "??????"
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

            if indexPath.row == 1{ //?????? ??????
                
                
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                prepareAnimation()
                showAnimation()
                
                currentStatus = 1
                feelsLikeLabel.isHidden = true
                tempSign.isHidden = false
                currentMaxMinLabel.isHidden = false

                
                let yesterdayCompared = Int(round(weatherResponse.current.temp - 273.15)) - Int(round(yesterdayResponse.current.temp - 273.15))
                
                //?????? ?????? ??????
                currentTempLabel.text = "\(Int(round(weatherResponse.current.temp - 273.15)))"
                currentMaxMinLabel.text = "?????? \(Int(round(weatherResponse.daily[0].temp.max - 273.15)))??/ ?????? \(Int(round(weatherResponse.daily[0].temp.min - 273.15)))??"
                if yesterdayCompared < 0 {
                    yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
                } else if yesterdayCompared == 0 {
                    yesterdayLabel.text = "????????? ????????????"
                } else {
                    yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
                }
                
                //?????? ??????
                
                let hourlyTime = weatherResponse.current.dt
                let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                    
                
                if weatherResponse.current.weather[0].id >= 200 && weatherResponse.current.weather[0].id <= 299 {
                    mainImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
                    todayWeatherLabel.text = "??????"
                } else if weatherResponse.current.weather[0].id >= 300 && weatherResponse.current.weather[0].id <= 599 {
                    mainImg.image = UIImage(systemName: "cloud.rain.fill")
                    todayWeatherLabel.text = "???"
                } else if weatherResponse.current.weather[0].id >= 600 && weatherResponse.current.weather[0].id <= 699 {
                    mainImg.image = UIImage(systemName: "snow")
                    todayWeatherLabel.text = "???"
                } else if weatherResponse.current.weather[0].id >= 700 && weatherResponse.current.weather[0].id <= 799 {
                    mainImg.image = UIImage(systemName: "cloud.fog.fill")
                    todayWeatherLabel.text = "??????"
                } else if weatherResponse.current.weather[0].id == 800 {
                    //?????? ?????? ?????? ?????? ??????
                    if hour <= 6 || hour >= 19 {
                        mainImg.image = UIImage(systemName: "moon.fill")
                        todayWeatherLabel.text = "??????"
                    } else {
                        mainImg.image = UIImage(systemName: "sun.max.fill")
                        todayWeatherLabel.text = "??????"
                    }
                } else if weatherResponse.current.weather[0].id == 801 {
                    //?????? ?????? ?????? ??????
                    if hour <= 6 || hour >= 19 {
                        mainImg.image = UIImage(systemName: "cloud.moon.fill")
                        todayWeatherLabel.text = "????????? ??????"
                    } else {
                        mainImg.image = UIImage(systemName: "cloud.sun.fill")
                        todayWeatherLabel.text = "????????? ??????"
                    }
                } else {
                    mainImg.image = UIImage(systemName: "cloud.fill")
                    todayWeatherLabel.text = "??????"
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
                
                //?????? ?????? ??????
                currentTempLabel.text = "\(Int(round(weatherResponse.current.feels_like - 273.15)))"
                currentMaxMinLabel.text = "?????? \(Int(round(weatherResponse.daily[0].temp.max - 273.15)))??/ ?????? \(Int(round(weatherResponse.daily[0].temp.min - 273.15)))??"
                if yesterdayCompared < 0 {
                    yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
                } else if yesterdayCompared == 0 {
                    yesterdayLabel.text = "????????? ????????????"
                } else {
                    yesterdayLabel.text = "???????????? \(abs(yesterdayCompared))?? ?????????"
                }
                
                //?????? ??????
                
                let hourlyTime = weatherResponse.current.dt
                let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                    
                
                if weatherResponse.current.weather[0].id >= 200 && weatherResponse.current.weather[0].id <= 299 {
                    mainImg.image = UIImage(systemName: "cloud.bolt.rain.fill")
                    todayWeatherLabel.text = "??????"
                } else if weatherResponse.current.weather[0].id >= 300 && weatherResponse.current.weather[0].id <= 599 {
                    mainImg.image = UIImage(systemName: "cloud.rain.fill")
                    todayWeatherLabel.text = "???"
                } else if weatherResponse.current.weather[0].id >= 600 && weatherResponse.current.weather[0].id <= 699 {
                    mainImg.image = UIImage(systemName: "snow")
                    todayWeatherLabel.text = "???"
                } else if weatherResponse.current.weather[0].id >= 700 && weatherResponse.current.weather[0].id <= 799 {
                    mainImg.image = UIImage(systemName: "cloud.fog.fill")
                    todayWeatherLabel.text = "??????"
                } else if weatherResponse.current.weather[0].id == 800 {
                    //?????? ?????? ?????? ?????? ??????
                    if hour <= 6 || hour >= 19 {
                        mainImg.image = UIImage(systemName: "moon.fill")
                        todayWeatherLabel.text = "??????"
                    } else {
                        mainImg.image = UIImage(systemName: "sun.max.fill")
                        todayWeatherLabel.text = "??????"
                    }
                } else if weatherResponse.current.weather[0].id == 801 {
                    //?????? ?????? ?????? ??????
                    if hour <= 6 || hour >= 19 {
                        mainImg.image = UIImage(systemName: "cloud.moon.fill")
                        todayWeatherLabel.text = "????????? ??????"
                    } else {
                        mainImg.image = UIImage(systemName: "cloud.sun.fill")
                        todayWeatherLabel.text = "????????? ??????"
                    }
                } else {
                    mainImg.image = UIImage(systemName: "cloud.fill")
                    todayWeatherLabel.text = "??????"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()


            } else if indexPath.row == 3 { //?????????
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "?????????"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 3
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentUvi = Int(round(weatherResponse.current.uvi))
                //?????? ?????? ??????
                if currentUvi < 2 {
                    mainImg.image = UIImage(systemName: "sun.dust")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "????????? ?????? : \(currentUvi)"
                } else if currentUvi >= 2 && currentUvi <= 5 {
                    mainImg.image = UIImage(systemName: "sun.dust.fill")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "????????? ?????? : \(currentUvi)"

                } else if currentUvi > 5 {
                    mainImg.image = UIImage(systemName: "sun.dust.fill")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "????????? ?????? : \(currentUvi)"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()

                
            } else if indexPath.row == 4 {
                
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "??????"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 4
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentWind = round(weatherResponse.current.wind_speed * 10) / 10
                //?????? ?????? ??????
                if currentWind < 1 {
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "?????? : \(currentWind)m/s"
                } else if currentWind >= 1 && currentWind <= 10 {
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "?????? : \(currentWind)m/s"

                } else if currentWind > 10{
                    mainImg.image = UIImage(systemName: "wind")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "?????? : \(currentWind)m/s"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()


            } else if indexPath.row == 5 {
                guard let weatherResponse = tempWeatherResponse else { return }
                guard let yesterdayResponse = tempYesterdayResponse else { return }

                
                todayWeatherLabel.text = "??????"
                tempSign.isHidden = true
                
                prepareAnimation()
                showAnimation()
                
                currentStatus = 5
                feelsLikeLabel.isHidden = true
                currentMaxMinLabel.isHidden = true
                
                let currentHumidity = weatherResponse.current.humidity
                //?????? ?????? ??????
                if currentHumidity < 30 {
                    mainImg.image = UIImage(systemName: "drop")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "??????: \(currentHumidity)%"
                } else if currentHumidity >= 30 && currentHumidity <= 60 {
                    mainImg.image = UIImage(systemName: "drop")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "??????: \(currentHumidity)%"

                } else if currentHumidity > 60{
                    mainImg.image = UIImage(systemName: "drop.fill")
                    currentTempLabel.text = "??????"
                    yesterdayLabel.text = "??????: \(currentHumidity)%"
                }
                
                todayCollectionView.reloadData()
                dailyTableView.reloadData()
            }
        }
    }
}

//???????????? ???

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

// ???????????? ???

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
