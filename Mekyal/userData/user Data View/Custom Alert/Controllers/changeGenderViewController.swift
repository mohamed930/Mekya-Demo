//
//  changeGenderViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 04/02/2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol Gender {
    func SendNewGender(Gender: String)
}

class changeGenderViewController: UIViewController {
    
    var changegenderview: changeGenderView! {
        guard isViewLoaded else { return nil }
        return (view as! changeGenderView)
    }
    
    var delegate: Gender!
    let changegenderviewmodel = changeGenderViewModel()
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        changegenderview.AlertViewBackground.SetCornerRadious(cornerRadious: 15, color: "#FFFFFF")
        changegenderview.MaleImageView.SetCornerRadious(cornerRadious: 15, color: "")
        changegenderview.FemaleImageView.SetCornerRadious(cornerRadious: 15, color: "")
        AddMaleTapGeuser()
        AddFemaleTapGeuser()
        BindToCancelButtonAction()
        BindToConfirmButtonAction()
    }
    
    func AddMaleTapGeuser() {
        changegenderviewmodel.AddGuester(view: changegenderview.MaleImageView) { [weak self] _ in
            self?.changegenderviewmodel.GenderBehaviour.accept("Male")
            self?.changegenderviewmodel.updateUI((self?.changegenderview.MaleImageView)!)
        }
    }
    
    func AddFemaleTapGeuser() {
        changegenderviewmodel.AddGuester(view: changegenderview.FemaleImageView) { [weak self] _ in
            self?.changegenderviewmodel.GenderBehaviour.accept("Female")
            self?.changegenderviewmodel.updateUI((self?.changegenderview.FemaleImageView)!)
        }
    }
    
    func BindToCancelButtonAction() {
        changegenderview.CancelButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.dismissPopupViewController(animationType: .Fade)
        }).disposed(by: disposebag)
    }
    
    func BindToConfirmButtonAction() {
        changegenderview.ConfirmButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.delegate.SendNewGender(Gender: self.changegenderviewmodel.GenderBehaviour.value)
            self.dismissPopupViewController(animationType: .Fade)
        }).disposed(by: disposebag)
    }
    
    
}
