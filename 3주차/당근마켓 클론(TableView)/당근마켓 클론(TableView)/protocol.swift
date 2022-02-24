//
//  protocol.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/24.
//

import Foundation
import UIKit

protocol SendDataDelegate {
    func sendData(data: HomeTableStruct)
}

protocol CellButtonDelegate {
    func didTappedLikeBtn(index: Int, like: Bool)
}
