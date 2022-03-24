//
//  infromationViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 17/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class infromationViewController: UIViewController {
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var NationalityTextField: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    
    @IBOutlet weak var MaleImage: UIImageView!
    @IBOutlet weak var FeMaleImage: UIImageView!
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!
    
    @IBOutlet weak var BoxView: UIView!
    
    let disposebag = DisposeBag()
    let informationviewmodel = informationViewModel()
    var picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        BoxView.SetViewShadow()
        SignupButton.SetCornerRadious()
        BindToTextField()
        HandleDoneinTextField()
        BindtToNationalityToPickerView()
        BindToAgeToPickerView()
        SetupGenderGeuster()
        ResponseToSignup()
        subscribeToEnableSignup()
        SubscribeToSignupButton()
        BackButton.CheckButtonDirectory()
        SubscribeToBackButtonAction()
    }
    
    // MARK:- TODO:- This Method For Bind Rxswift varible to textField
    func BindToTextField() {
        NameTextField.rx.text.orEmpty.bind(to: informationviewmodel.usernameBehaviour).disposed(by: disposebag)
        informationviewmodel.pickedNationalityBehaviour.accept(NationalityTextField.text!)
        informationviewmodel.pickedAgeBehaviour.accept(AgeTextField.text!)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Handle Done Button Action in textField.
    func HandleDoneinTextField() {
        NameTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.NameTextField.resignFirstResponder()
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Add PickerView To Nationality TextField.
    func BindtToNationalityToPickerView() {
        
        informationviewmodel.fillNationality()
        
        NationalityTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SetDataToPikcerView(self.NationalityTextField, self.informationviewmodel.nationalitiesBehaviour) { [weak self] picked in
                self?.informationviewmodel.pickedNationalityBehaviour.accept(picked)
            }
            
            self.NationalityTextField.HandleDoneButton1(vc: self, selector: #selector(self.N))
        }).disposed(by: disposebag)
    }
    @objc func N(_ sender: Any) {
        NationalityTextField.text = informationviewmodel.pickedNationalityBehaviour.value
    }
    // ------------------------------------------------
    
    
    // MARK:- TODO:- Add Age PickerView to TextField.
    func BindToAgeToPickerView() {
        
        informationviewmodel.FillAges()
        
        AgeTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SetDataToPikcerView(self.AgeTextField, self.informationviewmodel.AgesBehaviour) { [weak self] picked in
                self?.informationviewmodel.pickedAgeBehaviour.accept(picked)
            }
            
            self.AgeTextField.HandleDoneButton1(vc: self, selector: #selector(self.A))
        }).disposed(by: disposebag)
    }
    @objc func A() {
        AgeTextField.text = informationviewmodel.pickedAgeBehaviour.value
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- set tap Geuster action To images.
    func SetupGenderGeuster() {
        informationviewmodel.AddGuester(view: MaleImage) { [weak self] _ in
            guard let self = self else { return }
            
            self.MaleImage.layer.borderColor = UIColor.yellow.cgColor
            self.MaleImage.layer.borderWidth = 2
            self.MaleImage.layer.cornerRadius = 5
            self.informationviewmodel.pickedGenderBehaviour.accept("Male")
            
            self.FeMaleImage.layer.borderColor = UIColor.clear.cgColor
            self.FeMaleImage.layer.borderWidth = 0
        }
        
        informationviewmodel.AddGuester(view: FeMaleImage) { [weak self] _ in
            guard let self = self else { return }
            
            self.FeMaleImage.layer.borderColor = UIColor.yellow.cgColor
            self.FeMaleImage.layer.borderWidth = 2
            self.FeMaleImage.layer.cornerRadius = 5
            self.informationviewmodel.pickedGenderBehaviour.accept("Female")
            
            self.MaleImage.layer.borderColor = UIColor.clear.cgColor
            self.MaleImage.layer.borderWidth = 0
        }
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
    
    // MARK:- TODO:- This Method check if singup button is valid or not.
    func subscribeToEnableSignup() {
        informationviewmodel.isEnabledSignup.subscribe(onNext: { [weak self] isEnabled in
            guard let self = self else { return }
            
            if isEnabled {
                self.SignupButton.isEnabled = true
            }
            else {
                self.SignupButton.isEnabled = false
            }
            
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Response For BackEnd.
    func ResponseToSignup() {
        informationviewmodel.signupResponseBehaviour.subscribe(onNext: { [weak self] str in
            guard let self = self else { return }
            if str == ""{
                
            }
            else if str == "Success" {
                let storyboard = UIStoryboard(name: "Home View", bundle: nil)
                let nextVc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController")
                nextVc.modalPresentationStyle = .fullScreen
                self.present(nextVc, animated: true)
            }
            
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Add Signup Button Action to Button
    func SubscribeToSignupButton() {
        SignupButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            
            self.informationviewmodel.Signupoperation()
            
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Dismiss Keypad.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // ------------------------------------------------
    
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
