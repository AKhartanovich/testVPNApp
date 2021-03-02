//
//  CountryModel.swift
//  TestVPN
//
//  Created by MacBook on 2.03.21.
//

import Foundation
import UIKit

enum CountryModel: Int, CustomStringConvertible {
    
    case Belarus
    case Russia
    case USA
    case Germany
    
    var description: String {
        switch self {
        case .Belarus: return "Belarus"
        case .Germany: return "Germany"
        case .Russia: return "Russia"
        case .USA: return "USA"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Belarus: return UIImage(named: "belarus") ?? UIImage()
        case .Germany: return UIImage(named: "germany") ?? UIImage()
        case .Russia: return UIImage(named: "russia") ?? UIImage()
        case .USA: return UIImage(named: "usa") ?? UIImage()
        }
    }
}
