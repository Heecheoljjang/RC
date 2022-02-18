//
//  notificationViewController.swift
//  스타벅스 클론
//
//  Created by HeecheolYoon on 2022/02/18.
//

import UIKit
import UserNotifications

class notificationViewController: UIViewController {

    let notiCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func requestNotification() {
        let option = UNAuthorizationOptions(arrayLiteral: [.badge, .alert])
        notiCenter.requestAuthorization(options: option) { success, error in
            if success {
                self.sendLocalNotification(seconds: 5)
            } else {
                print("알림 허용 요청 오류")
            }
        }
    }
    private func sendLocalNotification(seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "제목"
        content.body = "테스트"
        content.userInfo = ["aa": "bb"]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notiCenter.add(request) { error in
            print("에러")
        }
    }
}
