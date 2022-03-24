//
//  choocelanguageViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import RxSwift
import RxCocoa
import MOLH

class choocelanguageViewController: UIViewController {
    
    @IBOutlet weak var EnglishView: UIView!
    @IBOutlet weak var ArabicView: UIView!
    
    @IBOutlet weak var BackButton: UIButton!
    
    var flag = false
    let choocelanguageviewmodel = choocelanguageViewModel()
    let disposebage = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if flag == false {
            BackButton.isHidden = true
        }
        else {
            BackButton.isHidden = false
            BackButton.CheckButtonDirectory()
        }
        
        AddEnglishGeusterAction()
        AddArabicGeusterAction()
        SubscribeToBackButtonAction()
    }
    
    // MARK:- TODO:- This Method For Check language and move to telephone.
    func AddEnglishGeusterAction() {
        choocelanguageviewmodel.AddGuester(view: EnglishView) { [weak self] _ in
            guard let self = self else { return }
            
            if ("lang".localized == "eng") {
                
                self.choocelanguageviewmodel.SaveLanguageStatus()
                
                let story = UIStoryboard(name: "Login Main", bundle: nil)
                let nextVc = story.instantiateViewController(withIdentifier: "teleViewController") as! telephoneViewController
                nextVc.modalPresentationStyle = .fullScreen
                
                self.present(nextVc, animated: true)
            }
            else {
                self.choocelanguageviewmodel.SaveLanguageStatus()
                MOLH.setLanguageTo("en")
                MOLH.reset()
            }
        }
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Check language and move to telephone.
    func AddArabicGeusterAction() {
        choocelanguageviewmodel.AddGuester(view: ArabicView) { [weak self] _ in
            guard let self = self else { return }
            
            if ("lang".localized == "ara") {
                
                self.choocelanguageviewmodel.SaveLanguageStatus()
                
                let story = UIStoryboard(name: "Login Main", bundle: nil)
                let nextVc = story.instantiateViewController(withIdentifier: "teleViewController") as! telephoneViewController
                nextVc.modalPresentationStyle = .fullScreen
                
                self.present(nextVc, animated: true)
            }
            else {
                self.choocelanguageviewmodel.SaveLanguageStatus()
                MOLH.setLanguageTo("ar")
                MOLH.reset()
            }
        }
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Action For Dismiss Keypad
    func SubscribeToBackButtonAction() {
        BackButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposebage)
    }
    // ------------------------------------------------

}
