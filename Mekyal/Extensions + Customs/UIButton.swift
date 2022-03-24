//
//  UIButton.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit

extension UIButton {
    func SetCornerRadious() {
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
    }
    
    func CheckButtonDirectory() {
        if "lang".localized == "eng" {
            self.setBackgroundImage(UIImage(named: "Back"), for: .normal)
        }
        else {
            self.setBackgroundImage(UIImage(named: "BackAr"), for: .normal)
        }
    }
    
    func SetBorder() {
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor().hexStringToUIColor(hex: "#29C17E").cgColor
        self.layer.borderWidth = 1
    }
}
