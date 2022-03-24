//
//  VerificationViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class VerificationViewModel {
    
    var digitoneBehaviour = BehaviorRelay<String>(value: "")
    var digittwoBehaviour = BehaviorRelay<String>(value: "")
    var digitthreeBehaviour = BehaviorRelay<String>(value: "")
    var digitfourBehaviour = BehaviorRelay<String>(value: "")
    
    var sendedTockenBehaviour = BehaviorRelay<String>(value: "")
    
    var responseBehaviour = BehaviorRelay<String>(value: "")
    
    var timer = Timer()
    var seconds = 240
    
    
    var isdigitoneBehaviour : Observable<Bool> {
        return digitoneBehaviour.asObservable().map { digit -> Bool in
            let isDigitEmpty = digit.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isDigitEmpty
        }
    }
    
    var isdigittwoBehaviour : Observable<Bool> {
        return digittwoBehaviour.asObservable().map { digit -> Bool in
            let isDigitEmpty = digit.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isDigitEmpty
        }
    }
    
    var isdigitthreeBehaviour : Observable<Bool> {
        return digitthreeBehaviour.asObservable().map { digit -> Bool in
            let isDigitEmpty = digit.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isDigitEmpty
        }
    }
    
    var isdigitfourBehaviour : Observable<Bool> {
        return digitfourBehaviour.asObservable().map { digit -> Bool in
            let isDigitEmpty = digit.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isDigitEmpty
        }
    }
    
    var isVerifiyEnabled: Observable<Bool> {
        return Observable.combineLatest(isdigitoneBehaviour,isdigittwoBehaviour,isdigitthreeBehaviour,isdigitfourBehaviour) {
            digitone , digittwo,digitthree,digitfour   in
            let verifiyValid = !digitone && !digittwo && !digitthree && !digitfour
            
            return verifiyValid
        }
    }
    
    func CheckisVerifySuccess() {
        if sendedTockenBehaviour.value == "" {
            responseBehaviour.accept("False")
        }
        else {
            responseBehaviour.accept("Success")
        }
    }
    
    // MARK:- TODO:- This Method For Configure Timer.
    func ConfigureTimer(vc: UIViewController,selector: Selector) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 4, target: vc, selector: selector, userInfo: nil, repeats: true)
    }
    
    func asString(style: DateComponentsFormatter.UnitsStyle, Time: TimeInterval) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second,.nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: Time) else {
            return ""
        }
        return formattedString
    }
    // ------------------------------------------------
    
}
