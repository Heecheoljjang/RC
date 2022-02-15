//
//  SceneDelegate.swift
//  스타벅스 클론
//
//  Created by 희철 on 2022/02/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var img: UIImageView? //스타벅스 블러 이미지
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let tabBar = self.window?.rootViewController as? UITabBarController {
            tabBar.tabBar.tintColor = .green
            tabBar.tabBar.unselectedItemTintColor = .systemGray3

            if let tabBarItems = tabBar.tabBar.items {
                tabBarItems[0].image = UIImage(named: "house.fill")
                tabBarItems[1].image = UIImage(named: "creditcard.fill")
                tabBarItems[2].image = UIImage(named: "cup.and.saucer.fill")
                tabBarItems[3].image = UIImage(named: "gift.fill")
                tabBarItems[4].image = UIImage(named: "list.bullet")

                tabBarItems[0].title = "Home"
                tabBarItems[1].title = "Pay"
                tabBarItems[2].title = "Order"
                tabBarItems[3].title = "Gift"
                tabBarItems[4].title = "Other"

                let image = UIImage(named: "house.fill")?.withRenderingMode(.alwaysOriginal)
                tabBarItems[0].image = image

                for tabbarItem in tabBarItems {
                    tabbarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .disabled)
                    tabbarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .selected)
                }

            }
            
        }
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = sb.instantiateViewController(withIdentifier: "event") as? EventViewController else { return }
//
//        vc.modalPresentationStyle = .fullScreen
//        tabBar.present(vc, animated: true, completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) { // 다시 포그라운드로 올 때
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        if let imgView = img {
            imgView.removeFromSuperview()
        }
    }

    func sceneWillResignActive(_ scene: UIScene) { //백그라운드 진입 전 호출되는 메서드
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        guard let window = window else {
            return
        }
        img = UIImageView(frame: window.frame)
        img?.image = UIImage(named: "starbucksBack")
        window.addSubview(img!)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


