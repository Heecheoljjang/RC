//
//  SearchViewController.swift
//  SpotifyUI
//
//  Created by 희철 on 2022/02/11.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.barTintColor = .custom
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension UIColor {
    class var custom: UIColor? { return UIColor(named: "Custom")}
}
