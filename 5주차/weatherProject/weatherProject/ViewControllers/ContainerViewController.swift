//
//  ContainerViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/12.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var tempLocation: String?
    var tempAirPollutionData: AirPollutionResponse?
    var currentStatus = 0
    var returnValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let location = tempLocation else { return }
        guard let airPollutionData = tempAirPollutionData else { return }
        
        //이미지
        if airPollutionData.list[0].main.aqi == 5 {
            statusImg.image = UIImage(systemName: "arrow.down")
            statusLabel.text = "매우 나쁨"
            statusImg.tintColor = .red
            recommendLabel.text = "공기가 매우 나빠요"
        } else if airPollutionData.list[0].main.aqi == 4 {
            statusImg.image = UIImage(systemName: "arrow.down.right")
            statusLabel.text = "나쁨"
            statusImg.tintColor = .orange
            recommendLabel.text = "공기가 나빠요"

        } else if airPollutionData.list[0].main.aqi == 3 {
            statusImg.image = UIImage(systemName: "arrow.right")
            statusLabel.text = "보통"
            statusImg.tintColor = .green
            recommendLabel.text = "나쁘지 않네요"

        } else if airPollutionData.list[0].main.aqi == 2 {
            statusImg.image = UIImage(systemName: "arrow.up.right")
            statusLabel.text = "좋음"
            statusImg.tintColor = .systemTeal
            recommendLabel.text = "공기가 좋네요"

        } else {
            statusImg.image = UIImage(systemName: "arrow.up")
            statusLabel.text = "매우 좋음"
            statusImg.tintColor = .link
            recommendLabel.text = "공기가 너무 좋아요. 나가세요."

        }
        
        locationLabel.text = "\(location)"
        
        leftView.backgroundColor = .systemGray5
        rightView.backgroundColor = .systemGray4

    }
    @IBAction func tapLeft(_ sender: Any) {
        currentStatus = 0
        leftView.backgroundColor = .systemGray5
        rightView.backgroundColor = .systemGray4
        myCollectionView.reloadData()
    }
    @IBAction func tapRight(_ sender: Any) {
        currentStatus = 1
        leftView.backgroundColor = .systemGray4
        rightView.backgroundColor = .systemGray5
        myCollectionView.reloadData()
    }
    
}

extension ContainerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let airPollutionData = tempAirPollutionData else { return 0 }

        if currentStatus == 0 {
            return 4
        } else {
            return airPollutionData.list.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "containerCell", for: indexPath) as? containerCollectionViewCell else { return UICollectionViewCell() }
        
        if let airPollutionData = tempAirPollutionData {
            if currentStatus == 0 {
                cell.detailLabel.isHidden = false
                if indexPath.row == 0 {
                    cell.titleLabel.text = "미세먼지"
                    if airPollutionData.list[0].components.pm10 <= 25 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up")
                        cell.cellStatusLabel.text = "매우 좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm10))) μg/m3"
                        cell.cellImg.tintColor = .link
                    } else if airPollutionData.list[0].components.pm10 > 25 && airPollutionData.list[0].components.pm10 <= 50 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up.right")
                        cell.cellStatusLabel.text = "좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm10))) μg/m3"
                        cell.cellImg.tintColor = .systemTeal
                    } else if airPollutionData.list[0].components.pm10 > 50 && airPollutionData.list[0].components.pm10 <= 90 {
                        cell.cellImg.image = UIImage(systemName: "arrow.right")
                        cell.cellStatusLabel.text = "보통"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm10))) μg/m3"
                        cell.cellImg.tintColor = .green

                    } else if airPollutionData.list[0].components.pm10 > 90 && airPollutionData.list[0].components.pm10 <= 180 {
                        cell.cellImg.image = UIImage(systemName: "arrow.down.right")
                        cell.cellStatusLabel.text = "나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm10))) μg/m3"
                        cell.cellImg.tintColor = .orange

                    } else {
                        cell.cellImg.image = UIImage(systemName: "arrow.down")
                        cell.cellStatusLabel.text = "매우나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm10))) μg/m3"
                        cell.cellImg.tintColor = .red

                    }
                } else if indexPath.row == 1{
                    cell.titleLabel.text = "초미세먼지"
                    if airPollutionData.list[0].components.pm2_5 <= 15 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up")
                        cell.cellStatusLabel.text = "매우 좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm2_5))) μg/m3"
                        cell.cellImg.tintColor = .link
                    } else if airPollutionData.list[0].components.pm2_5 > 15 && airPollutionData.list[0].components.pm2_5 <= 30 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up.right")
                        cell.cellStatusLabel.text = "좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm2_5))) μg/m3"
                        cell.cellImg.tintColor = .systemTeal
                    } else if airPollutionData.list[0].components.pm2_5 > 30 && airPollutionData.list[0].components.pm2_5 <= 55 {
                        cell.cellImg.image = UIImage(systemName: "arrow.right")
                        cell.cellStatusLabel.text = "보통"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm2_5))) μg/m3"
                        cell.cellImg.tintColor = .green

                    } else if airPollutionData.list[0].components.pm2_5 > 55 && airPollutionData.list[0].components.pm2_5 <= 110 {
                        cell.cellImg.image = UIImage(systemName: "arrow.down.right")
                        cell.cellStatusLabel.text = "나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm2_5))) μg/m3"
                        cell.cellImg.tintColor = .orange

                    } else {
                        cell.cellImg.image = UIImage(systemName: "arrow.down")
                        cell.cellStatusLabel.text = "매우나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.pm2_5))) μg/m3"
                        cell.cellImg.tintColor = .red

                    }
                } else if indexPath.row == 2{
                    cell.titleLabel.text = "이산화질소"
                    if airPollutionData.list[0].components.no2 <= 50 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up")
                        cell.cellStatusLabel.text = "매우 좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.no2))) μg/m3"
                        cell.cellImg.tintColor = .link
                    } else if airPollutionData.list[0].components.no2 > 50 && airPollutionData.list[0].components.no2 <= 100 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up.right")
                        cell.cellStatusLabel.text = "좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.no2))) μg/m3"
                        cell.cellImg.tintColor = .systemTeal
                    } else if airPollutionData.list[0].components.no2 > 100 && airPollutionData.list[0].components.no2 <= 200 {
                        cell.cellImg.image = UIImage(systemName: "arrow.right")
                        cell.cellStatusLabel.text = "보통"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.no2))) μg/m3"
                        cell.cellImg.tintColor = .green

                    } else if airPollutionData.list[0].components.no2 > 200 && airPollutionData.list[0].components.no2 <= 400 {
                        cell.cellImg.image = UIImage(systemName: "arrow.down.right")
                        cell.cellStatusLabel.text = "나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.no2))) μg/m3"
                        cell.cellImg.tintColor = .orange

                    } else {
                        cell.cellImg.image = UIImage(systemName: "arrow.down")
                        cell.cellStatusLabel.text = "매우나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.no2))) μg/m3"
                        cell.cellImg.tintColor = .red

                    }
                } else if indexPath.row == 3{
                    cell.titleLabel.text = "오존"
                    if airPollutionData.list[0].components.o3 <= 60 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up")
                        cell.cellStatusLabel.text = "매우 좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.o3))) μg/m3"
                        cell.cellImg.tintColor = .link
                    } else if airPollutionData.list[0].components.o3 > 60 && airPollutionData.list[0].components.o3 <= 120 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up.right")
                        cell.cellStatusLabel.text = "좋음"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.o3))) μg/m3"
                        cell.cellImg.tintColor = .systemTeal
                    } else if airPollutionData.list[0].components.o3 > 120 && airPollutionData.list[0].components.o3 <= 180 {
                        cell.cellImg.image = UIImage(systemName: "arrow.right")
                        cell.cellStatusLabel.text = "보통"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.o3))) μg/m3"
                        cell.cellImg.tintColor = .green

                    } else if airPollutionData.list[0].components.o3 > 180 && airPollutionData.list[0].components.o3 <= 240 {
                        cell.cellImg.image = UIImage(systemName: "arrow.down.right")
                        cell.cellStatusLabel.text = "나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.o3))) μg/m3"
                        cell.cellImg.tintColor = .orange

                    } else {
                        cell.cellImg.image = UIImage(systemName: "arrow.down")
                        cell.cellStatusLabel.text = "매우나쁨"
                        cell.detailLabel.text = "\(Int(round(airPollutionData.list[0].components.o3))) μg/m3"
                        cell.cellImg.tintColor = .red

                    }
                }
            } else if currentStatus == 1 {
                cell.detailLabel.isHidden = true
                if let hourlyTime = tempAirPollutionData?.list[indexPath.row].dt {
                    let date = Date(timeIntervalSince1970: TimeInterval(hourlyTime))
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)

                    //시간
                    if hour > 0 && hour <= 11 {
                        cell.titleLabel.text = "오전 \(hour)시"
                    } else if hour == 12 {
                        cell.titleLabel.text = "오후 \(hour)시"
                    } else if hour == 0 {
                        cell.titleLabel.text = "오전 12시"
                    } else {
                        cell.titleLabel.text = "오후 \(hour - 12)시"
                    }
                }
                if let hourlyDust = tempAirPollutionData?.list[indexPath.row].components.pm10 {
                    if hourlyDust <= 25 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up")
                        cell.cellStatusLabel.text = "매우 좋음"
                        cell.cellImg.tintColor = .link
                    } else if hourlyDust > 25 && hourlyDust <= 50 {
                        cell.cellImg.image = UIImage(systemName: "arrow.up.right")
                        cell.cellStatusLabel.text = "좋음"
                        cell.cellImg.tintColor = .systemTeal
                    } else if hourlyDust > 50 && hourlyDust <= 90 {
                        cell.cellImg.image = UIImage(systemName: "arrow.right")
                        cell.cellStatusLabel.text = "보통"
                        cell.cellImg.tintColor = .green

                    } else if hourlyDust > 90 && hourlyDust <= 180 {
                        cell.cellImg.image = UIImage(systemName: "arrow.down.right")
                        cell.cellStatusLabel.text = "나쁨"
                        cell.cellImg.tintColor = .orange

                    } else {
                        cell.cellImg.image = UIImage(systemName: "arrow.down")
                        cell.cellStatusLabel.text = "매우나쁨"
                        cell.cellImg.tintColor = .red

                    }
                }
            }
        }
        return cell
    }
}

class containerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellStatusLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
}
