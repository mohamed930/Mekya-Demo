//
//  choocelanguageViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class choocelanguageViewModel {
    
    let disposeBag = DisposeBag()
    
    func AddGuester (view: UIView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposeBag)
    }
    
    func SaveLanguageStatus() {
        UserDefaults.standard.set(1, forKey: "language")
        UserDefaults.standard.synchronize()
    }
}
