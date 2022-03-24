//
//  AppDelegate.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import IQKeyboardManagerSwift
import MOLH

@main
class AppDelegate: UIResponder, UIApplicationDelegate , MOLHResetable{
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
         CheckMessage()
        MOLH.shared.activate(true)
        return true
    }

    func CheckMessage() {
        let language = UserDefaults.standard.object(forKey: "language") as? Int
        
        if language == nil {
            MakeViewControolerisInit(StroyName: "Login Main", Id: "languageViewController")
        }
        else {
            MakeViewControolerisInit(StroyName: "Login Main", Id: "teleViewController")
        }
    }
        
   // MARK:- TODO:- This Method for Set root VC.
   private func MakeViewControolerisInit(StroyName: String ,Id: String) {
       
       self.window = UIWindow(frame: UIScreen.main.bounds)

       let storyboard = UIStoryboard(name: StroyName , bundle: nil)

       let initialViewController = storyboard.instantiateViewController(withIdentifier: Id)

       self.window?.rootViewController = initialViewController
       self.window?.makeKeyAndVisible()

   }
   // ------------------------------------------------
    
    func reset() {
        let stry = UIStoryboard(name: "Login Main", bundle: nil)
        window?.rootViewController = stry.instantiateViewController(withIdentifier: "teleViewController")
    }


}

