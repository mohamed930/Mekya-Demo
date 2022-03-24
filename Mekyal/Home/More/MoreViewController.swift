//
//  MoreViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 02/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MoreViewController: UIViewController {
    
    @IBOutlet weak var ProfileView: UIStackView!
    @IBOutlet weak var OrderHistoryView: UIStackView!
    @IBOutlet weak var LanguageView: UIStackView!
    @IBOutlet weak var MakeCellView: UIStackView!
    
    let telephone = "+201273101459"
    
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        SetProfileTap()
        SetOrderHistoryTap()
        SetLanguageTap()
        MakeCallTap()
    }
    
    func SetProfileTap() {
        AddGuester(view: ProfileView) { [weak self] _ in
            guard let self = self else { return }
            
            let story = UIStoryboard(name: "user Data", bundle: nil)
            let nextVC = story.instantiateViewController(withIdentifier: "ProfileViewController") as! userProfileViewController
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
    
    func SetOrderHistoryTap() {
        AddGuester(view: OrderHistoryView) { [weak self] _ in
            guard let self = self else { return }
            
            let story = UIStoryboard(name: "user Data", bundle: nil)
            let nextVC = story.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
    
    func SetLanguageTap() {
        AddGuester(view: LanguageView) { [weak self] _ in
            guard let self = self else { return }
            
            let story = UIStoryboard(name: "Login Main", bundle: nil)
            let nextVC = story.instantiateViewController(withIdentifier: "languageViewController") as! choocelanguageViewController
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.flag = true
            self.present(nextVC, animated: true)
        }
    }
    
    func MakeCallTap() {
        AddGuester(view: MakeCellView) { _ in
            let url = URL(string: "TEL://\(self.telephone)")
            UIApplication.shared.open(url!, options: [:])
        }
    }
    
    private func AddGuester (view: UIStackView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposebag)
    }
}
