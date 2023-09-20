//
//  Ext+UIApplication.swift
//  VisionPOC
//
//  Created by Save, Kautilya on 9/20/23.
//

import UIKit

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}
