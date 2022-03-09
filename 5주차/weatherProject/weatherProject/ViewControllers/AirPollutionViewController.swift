//
//  AirPollutionViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/09.
//

import UIKit

class AirPollutionViewController: UIViewController {
    
    var lat: Double?
    var long: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myLat = lat else { return }
        guard let myLong = long else { return }
        
        //AirPollutionRequest().getAirPollutionData(lat: myLat, long: myLong, viewcontroller: self)
    }
}
