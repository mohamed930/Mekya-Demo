//
//  VerificationCodeViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class VerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var BoxView: UIView!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var DigitOne: UITextField!
    @IBOutlet weak var DigitTwo: UITextField!
    @IBOutlet weak var DigitThree: UITextField!
    @IBOutlet weak var DigitFour: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var telephoneNumber: String!
    var seconds = 240
    let disposebag = DisposeBag()
    let verifiyviewmodel = VerificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BoxView.SetViewShadow()
        verifyButton.SetCornerRadious()
        telephoneLabel.text = "+2" + telephoneNumber!
        DigitOne.becomeFirstResponder()
        SetTime()
        BindToTextField()
        isVerifyEnabled()
        SubscribeToMessageResponse()
        SubscribeToVerifyButtonAction()
        BackButton.CheckButtonDirectory()
        SubscribeToBackButtonAction()
    }
    
    // MARK:- TODO:- This Method For Bind TextField to Rx Swift.
    func BindToTextField() {
        DigitOne.rx.text.orEmpty.bind(to: verifiyviewmodel.digitoneBehaviour).disposed(by: disposebag)
        DigitTwo.rx.text.orEmpty.bind(to: verifiyviewmodel.digittwoBehaviour).disposed(by: disposebag)
        DigitThree.rx.text.orEmpty.bind(to: verifiyviewmodel.digitthreeBehaviour).disposed(by: disposebag)
        DigitFour.rx.text.orEmpty.bind(to: verifiyviewmodel.digitfourBehaviour).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Verify if Button Enabled or not.
    func isVerifyEnabled() {
        verifiyviewmodel.isVerifiyEnabled.subscribe(onNext: { [weak self] isNotEmpty in
            guard let self = self else {return}
            
            if isNotEmpty {
                self.verifyButton.isEnabled = true
            }
            else {
                self.verifyButton.isEnabled = false
            }
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Subscribe To Response.
    func SubscribeToMessageResponse() {
        verifiyviewmodel.responseBehaviour.subscribe(onNext: { [weak self] response in
            guard let self = self else { return }
            if response == "Success" {
                
                let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
                nextVc.modalPresentationStyle = .fullScreen
                
                self.present(nextVc, animated: true)
            }
            else if response == "False" {
                print("Reponse False")
            }
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Verifiy Button Action.
    func SubscribeToVerifyButtonAction() {
        verifyButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.verifiyviewmodel.CheckisVerifySuccess()
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Action For Dismiss Keypad
    func SubscribeToBackButtonAction() {
        BackButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func SetTime() {
        verifiyviewmodel.ConfigureTimer(vc: self, selector: #selector(timerset))
    }
    
    @objc func timerset(TimerLabel: UILabel) {
        seconds = seconds - 1
        timeLabel.text = "Resend in ".localized + "\(verifiyviewmodel.asString(style: .positional, Time: TimeInterval(seconds)))" + "s".localized
        
        if seconds == 0 {
            timeLabel.text = "--:--"
        }
        else if seconds <= 59 {
            timeLabel.text = "Resend in ".localized + "--:\(seconds)"
        }
        else if seconds == 60 {
            timeLabel.text = "Resend in ".localized + "01:--"
        }
        else if seconds == 120 {
            timeLabel.text = "Resend in ".localized + "02:--"
        }
        else if seconds == 180 {
            timeLabel.text = "Resend in ".localized + "03:--"
        }
        
    }
}

extension VerificationCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string != "" {
            if textField.text == "" {
                textField.text = string
                let nextrespons: UIResponder? = view.viewWithTag(textField.tag + 1)
                if nextrespons != nil {
                    nextrespons?.becomeFirstResponder()
                }
                else {
                    DigitFour.resignFirstResponder()
                    
                    // MARK:- TODO:- in this block add function for API and Show Full Code.
                    print("Code: \(verifiyviewmodel.digitoneBehaviour.value + verifiyviewmodel.digittwoBehaviour.value + verifiyviewmodel.digitthreeBehaviour.value + verifiyviewmodel.digitfourBehaviour.value)")
                    
                    let code = verifiyviewmodel.digitoneBehaviour.value + verifiyviewmodel.digittwoBehaviour.value + verifiyviewmodel.digitthreeBehaviour.value + verifiyviewmodel.digitfourBehaviour.value
                    
                    verifiyviewmodel.sendedTockenBehaviour.accept(code)
                    print(verifiyviewmodel.sendedTockenBehaviour.value)
                }
            }
            return false
        }
        else {
            textField.text = string
            let nextrespons: UIResponder? = view.viewWithTag(textField.tag - 1)
            if nextrespons != nil {
                nextrespons?.becomeFirstResponder()
            }
            return false
        }
    }
    
}
