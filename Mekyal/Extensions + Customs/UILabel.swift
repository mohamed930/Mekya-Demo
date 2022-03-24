//
//  UILabel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 29/01/2022.
//

import Foundation
import MOLH

extension UILabel {
    func SetDirection() {
        if "lang".localized == "eng" {
            self.textAlignment = .right
        }
        else {
            self.textAlignment = .left
        }
    }
}
