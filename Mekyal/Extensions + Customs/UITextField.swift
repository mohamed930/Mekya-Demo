//
//  UITextField.swift
//  Mekyal
//
//  Created by Mohamed Ali on 17/01/2022.
//

import UIKit
import MOLH

extension UITextField {
    func HandleDoneButton1(vc: UIViewController,selector: Selector) {
        self.keyboardToolbar.doneBarButton.setTarget(vc, action: selector)
    }
    
    func setPadding(paddingValue:Int,PlaceHolder:String , Color:UIColor) {
            
            if "lang".localized == "en" || MOLHLanguage.currentAppleLanguage() == "en" {
                self.textAlignment = .left
                let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: 20))
                self.leftView = paddingView
                self.leftViewMode = .always
            }
            else if "lang".localized == "ar" || MOLHLanguage.currentAppleLanguage() == "ar" {
                self.textAlignment = .right
                let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: 20))
                self.leftView = paddingView
                self.leftViewMode = .always
            }
            
        self.attributedPlaceholder = NSAttributedString(string: PlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: Color])
        }
}
