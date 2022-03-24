//
//  AddressViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import RxCocoa
import RxSwift

class AddressViewModel {
    let typeBehaviour = BehaviorRelay<String>(value: "Villa")
    let AreaBehaviour = BehaviorRelay<String>(value: "")
    let groupBehaviour = BehaviorRelay<String>(value: "")
    
    let typesArrBehaviour = BehaviorRelay<[String]>(value: [])
    let AreaArrBehaviour  = BehaviorRelay<[String]>(value: [])
    let groupArrBehaviour = BehaviorRelay<[String]>(value: [])
    
    let VillaNumberBehaviour = BehaviorRelay<String>(value: "")
    let AptNumberBehaviour   = BehaviorRelay<String>(value: "")
    
    let ShopingNameBehaviour = BehaviorRelay<String>(value: "")
    let AddressBehaviour     = BehaviorRelay<String>(value: "")
    
    func FillTypes() {
        let arr = ["Villa".localized, "Building".localized, "Commercial".localized] // handle in localizable
        typesArrBehaviour.accept(arr)
    }
    
    func ActionForPicked(_ view1: UIView, _ view2: UIView, aptView: UIView, label: UILabel) {
        let picked = typeBehaviour.value
        
        if picked == "Villa".localized {
            view1.isHidden = true
            view2.isHidden = false
            aptView.isHidden = true
            label.text = "Villa".localized
        }
        else if picked == "Building".localized {
            view1.isHidden = true
            view2.isHidden = false
            aptView.isHidden = false
            label.text = "Building".localized
        }
        else {
            view1.isHidden = false
            view2.isHidden = true
            aptView.isHidden = true
        }
    }
    
    func FillAreaList() {
        let picked = typeBehaviour.value
        
        if picked == "Villa".localized {
            let arr = ["VG1","VG2","VG3","VG4","VG5","VG6"]
            AreaArrBehaviour.accept([])
            AreaArrBehaviour.accept(arr)
            AreaBehaviour.accept("VG1")
        }
        else if picked == "Building".localized {
            let arr = ["B1","B2","B3","B4","B5","B6"]
            AreaArrBehaviour.accept([])
            AreaArrBehaviour.accept(arr)
            AreaBehaviour.accept("B1")
        }
    }
    
    func FillGroup() {
        let arr = ["1","2","3","4","5","6"]
        groupArrBehaviour.accept(arr)
    }
}
