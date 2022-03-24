//
//  changeGenderViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 04/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class changeGenderViewModel {
    var GenderBehaviour = BehaviorRelay<String>(value: "")
    let disposebag = DisposeBag()
    
    func AddGuester (view: UIImageView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposebag)
    }
    
    func updateUI(_ img: UIImageView) {
        img.layer.borderColor = UIColor.yellow.cgColor
        img.layer.borderWidth = 2
        img.layer.cornerRadius = 5
        
        img.layer.borderColor = UIColor.clear.cgColor
        img.layer.borderWidth = 0
    }
}
