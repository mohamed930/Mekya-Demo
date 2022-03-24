//
//  telephoneViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import RxCocoa
import RxSwift

class telephoneViewController: UIViewController {
    
    @IBOutlet weak var BoxView: UIView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var telephoneView: UIView!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var termsAndCondition: UILabel!
    
    let telephoneviewmodel = telephoneViewModel()
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        BoxView.SetViewShadow()
        NextButton.SetCornerRadious()
        telephoneView.SetBorderToView()
        
        BindToTelephone()
        isButtonEnabled()
        SubscribeToSentSMSResponse()
        SubscribeNextButtonAction()
    }
    
    // MARK:- TODO:- This Method For Bind Value to his rxSwift varible.
    func BindToTelephone() {
        telephoneTextField.rx.text.orEmpty.bind(to: telephoneviewmodel.telephoneBehaviour).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Enable Button if telephone have value.
    func isButtonEnabled() {
        telephoneviewmodel.isverifiyEnabled.subscribe(onNext: { [weak self] isEmpty in
            guard let self = self else { return }
            
            if isEmpty {
                self.NextButton.isEnabled = false
            }
            else {
                self.NextButton.isEnabled = true
            }
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Wait response to SMS API And Make Action.
    func SubscribeToSentSMSResponse() {
        telephoneviewmodel.SentSuccessBehaviour.subscribe(onNext: { [weak self] response in
            guard let self = self else { return }
            
            if response == nil {
                
            }
            else if response == true {
                let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationCodeViewController
                
                nextVc.telephoneNumber = self.telephoneviewmodel.telephoneBehaviour.value
    
                nextVc.modalPresentationStyle = .fullScreen
    
                self.present(nextVc, animated: true)
            }
            else {
                print("Error in your connection!")
            }
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Add Action To Next Button.
    func SubscribeNextButtonAction() {
        NextButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.telephoneviewmodel.SendSMSMessage()
            
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Dismiss KeyPad For touching screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // ------------------------------------------------

}
