//
//  customtabBar.swift
//  Mekyal
//
//  Created by Mohamed Ali on 02/02/2022.
//

import UIKit

class customtabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fix Nav Bar tint issue in iOS 15.0 or later - is transparent w/o code below
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor().hexStringToUIColor(hex: "#D8DAE0")
            UITabBar.appearance().standardAppearance = appearance
            
            #if swift(>=5.5) // Only run on Xcode version >= 13 (Swift 5.5 was shipped first with Xcode 13).
                UITabBar.appearance().scrollEdgeAppearance = appearance
            #endif
        }
    }

}
