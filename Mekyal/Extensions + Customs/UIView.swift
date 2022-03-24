//
//  UIView.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit

extension UIView {
    func SetCornerRadious(cornerRadious: CGFloat, color: String) {
        self.layer.cornerRadius = cornerRadious
        self.layer.masksToBounds = true
        if color == "" {
            self.layer.borderColor = .none
        }
        else {
            self.layer.borderColor = UIColor().hexStringToUIColor(hex: color).cgColor
        }
        
        self.layer.borderWidth = 1
    }
    
    func SetViewShadow() {
        self.layer.cornerRadius = 12
        self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.layer.shadowColor = UIColor().hexStringToUIColor(hex: "#CBCED8").cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius = 12.0
        self.layer.masksToBounds = false
    }
    
    func SetAllViewShadow() {
        self.layer.cornerRadius = 5
//        self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.layer.shadowColor = UIColor().hexStringToUIColor(hex: "#CBCED8").cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
    
    func SetBorderToView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor().hexStringToUIColor(hex: "#707070").cgColor
        self.layer.masksToBounds = false
    }
    
    func SetViewBorderCircle() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}
