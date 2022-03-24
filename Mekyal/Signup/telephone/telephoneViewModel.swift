//
//  telephoneViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class telephoneViewModel {
    var telephoneBehaviour = BehaviorRelay<String>(value: "")
    var SentSuccessBehaviour = BehaviorRelay<Bool?>(value: nil)
    
    var isverifiyEnabled : Observable<Bool> {
        return telephoneBehaviour.asObservable().map { tele -> Bool in
            let istelephoneEmpty = tele.trimmingCharacters(in: .whitespaces).isEmpty
            
            return istelephoneEmpty
        }
    }
    
    func SendSMSMessage() {
        SentSuccessBehaviour.accept(true)
    }
}
