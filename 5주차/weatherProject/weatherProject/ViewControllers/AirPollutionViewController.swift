//
//  AirPollutionViewController.swift
//  weatherProject
//
//  Created by HeecheolYoon on 2022/03/09.
//

import UIKit

class AirPollutionViewController: UIViewController {
    
    var tempAirPollutionData: AirPollutionResponse?
    var tempLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dust" {
            guard let vc = segue.destination as? ContainerViewController else { return }
            
            vc.tempLocation = tempLocation
            vc.tempAirPollutionData = tempAirPollutionData
        }
    }
}
