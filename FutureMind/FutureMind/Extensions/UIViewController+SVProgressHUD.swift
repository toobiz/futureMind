//
//  UIViewController+SVProgressHUD.swift
//  FutureMind
//
//  Created by Michal Tubis on 16.06.2018.
//  Copyright © 2018 Mike Tubis. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController {
    var progressHUDVisible: Bool {
        set {
            if newValue {
                if !SVProgressHUD.isVisible() {
                    SVProgressHUD.setDefaultMaskType(.custom)
                    SVProgressHUD.setDefaultStyle(.custom)
                    SVProgressHUD.setForegroundColor(UIColor.gray)
                    SVProgressHUD.setBackgroundColor(UIColor.white)
                    SVProgressHUD.show()
                }
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        get {
            return SVProgressHUD.isVisible()
        }
    }
}
