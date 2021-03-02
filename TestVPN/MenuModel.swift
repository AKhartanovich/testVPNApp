//
//  MenuModel.swift
//  TestVPN
//
//  Created by MacBook on 2.03.21.
//

import Foundation
import UIKit

enum MenuModel: Int, CustomStringConvertible {
    
    case About
    
    var description: String {
        switch self {
        case .About: return "About"
        }
    }
    
    var image: UIImage {
        switch self {
        case .About: return UIImage(named: "about") ?? UIImage()
        }
    }
}
