//
//  userProfileViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 29/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class userProfileViewController: UIViewController, Gender {
    
    @IBOutlet weak var genderImageVeiw: UIImageView!
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var AddressTextFeild: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
    @IBOutlet weak var logoutStackView: UIStackView!
    @IBOutlet weak var BackButton: UIButton!
    
    let userprofileviewmodel = userProfileViewModel()
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        BackButton.CheckButtonDirectory()
        BindToBackButton()
        AddCityPickerView()
        AddAgePickerView()
        AddTapGeusterToImageView()
        SubscribeToLogout()
        BindToLogoutAction()
    }
    
    @IBAction func EditDataAction(_ sender: UIButton) {
        if sender.tag == 1 {
            userprofileviewmodel.AddTextFieldToAlertOperation(title: "UpdateName".localized , message: "userNewName".localized , ob: self, placeHolder: "EnterName".localized, keytype: .default) { _ in
                self.userNameLabel.text =  self.userprofileviewmodel.textFieldBehaviour.value
            }
        }
        else if sender.tag == 2 {
            userprofileviewmodel.AddTextFieldToAlertOperation(title: "Updateaddress".localized, message: "newaddress".localized, ob: self, placeHolder: "EnterAddress".localized , keytype: .default) { _ in
                self.AddressTextFeild.text =  self.userprofileviewmodel.textFieldBehaviour.value
            }
        }
        else if sender.tag == 3 {
            userprofileviewmodel.AddTextFieldToAlertOperation(title: "Updatetelephone".localized , message: "newtele".localized, ob: self, placeHolder: "Entertelephone".localized, keytype: .phonePad) { _ in
                self.PhoneTextField.text =  self.userprofileviewmodel.textFieldBehaviour.value
            }
        }
    }
    
    func BindToBackButton() {
        BackButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposebag)
    }
    
    func AddCityPickerView() {
        userprofileviewmodel.fillNationality()
        
        SetDataToPikcerView(CityTextField, userprofileviewmodel.nationalitiesBehaviour) { picked in
            self.userprofileviewmodel.pickedNationalityBehaviour.accept(picked)
            self.CityTextField.text = picked
        }
    }
    
    func AddAgePickerView() {
        userprofileviewmodel.FillAges()
        
        SetDataToPikcerView(AgeTextField, userprofileviewmodel.AgesBehaviour) { picked in
            self.userprofileviewmodel.pickedAgeBehaviour.accept(picked)
            self.AgeTextField.text = picked
        }
    }
    
    func AddTapGeusterToImageView() {
        userprofileviewmodel.AddGuester(view: genderImageVeiw) { [weak self] _ in
            guard let self = self else { return }
            
            let nextVC: changeGenderViewController = changeGenderViewController(nibName: "ChangeGender", bundle: nil)
            self.view.alpha = 1.0
            nextVC.delegate = self
            self.presentpopupViewController(popupViewController: nextVC, animationType: .Fade, completion: {() -> Void in })
        }
    }
    
    func SendNewGender(Gender: String) {
        self.dismissPopupViewController(animationType: .Fade)
        print("Gender is \(Gender)")
    }
    
    func SubscribeToLogout() {
        userprofileviewmodel.logoutOperation.subscribe(onNext: { [weak self] res in
            guard let self = self else { return }
            
            if res == nil {
                
            }
            else if res == true {
                let story = UIStoryboard(name: "Login Main", bundle: nil)
                let nextVC = story.instantiateViewController(withIdentifier: "teleViewController") as! telephoneViewController
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true)
            }
            else {
                print("Error in server")
            }
        }).disposed(by: disposebag)
    }
    
    func BindToLogoutAction() {
        userprofileviewmodel.AddGuester(view: logoutStackView) { [weak self] _ in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "Logout".localized, message: "logmess".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Logout".localized, style: .destructive, handler: { _ in
                self.userprofileviewmodel.LogoutOperation()
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    private func SetDataToPikcerView(_ text: UITextField,_ list: BehaviorRelay<[String]>, _ completion: @escaping (String) -> ()) {
        let pickerView = UIPickerView()
        
        pickerView.backgroundColor = UIColor.white
        pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        
        let items: Observable<[String]> = Observable.of(list.value)
        
        items.bind(to: pickerView.rx.itemTitles) { (row, element) in
            return element
        }
        .disposed(by: disposebag)
        
        // Bind Selected Item.
        Observable
            .zip(pickerView.rx.itemSelected, pickerView.rx.modelSelected(String.self))
            .bind { selectedIndex, branch in
                completion(branch.first!)
            }.disposed(by: disposebag)
        
        text.inputView = pickerView
    }
}
