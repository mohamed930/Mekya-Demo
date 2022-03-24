//
//  AddressViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 16/01/2022.
//

import UIKit
import RxCocoa
import RxSwift

class AddressViewController: UIViewController {
    
    @IBOutlet weak var Resistanttype: UITextField!
    @IBOutlet weak var AreaTextField: UITextField!
    
    @IBOutlet weak var GroupNumber: UITextField!
    @IBOutlet weak var BuildingNumber: UITextField!
    @IBOutlet weak var BuildingLabel: UILabel!
    @IBOutlet weak var AptNumber: UITextField!
    
    @IBOutlet weak var AptView: UIView!
    @IBOutlet weak var VillaGroudView: UIView!
    
    @IBOutlet weak var ShopName: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var ShopGroupView: UIView!
    
    @IBOutlet weak var BoxView: UIView!
    
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    
    let addressviewmodel = AddressViewModel()
    let disposebag = DisposeBag()
    var picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        BoxView.SetViewShadow()
        NextButton.SetCornerRadious()
        SetNextToShopName()
        SetNextToAddress()
        SetTypesToPickerView()
        SetAreaToPickerView()
        SetGroupTextFieldToPickerView()
        SubscribeToNextButton()
        BackButton.CheckButtonDirectory()
        SubscribeToBackButtonAction()
    }
    
    // MARK:- TODO:- This Method For Bind typeofInfraction TextField.
    func BindToTextField() {
        Resistanttype.rx.text.orEmpty.bind(to: addressviewmodel.typeBehaviour).disposed(by: disposebag)
        BuildingNumber.rx.text.orEmpty.bind(to: addressviewmodel.VillaNumberBehaviour).disposed(by: disposebag)
        AptNumber.rx.text.orEmpty.bind(to: addressviewmodel.AptNumberBehaviour).disposed(by: disposebag)
        ShopName.rx.text.orEmpty.bind(to: addressviewmodel.ShopingNameBehaviour).disposed(by: disposebag)
        AddressTextField.rx.text.orEmpty.bind(to: addressviewmodel.AddressBehaviour).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Add PickerView to Resistanttype textField.
    func SetTypesToPickerView() {
        
        addressviewmodel.FillTypes()
        
        Resistanttype.rx.controlEvent(.editingDidBegin).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SetDataToPikcerView(self.Resistanttype, self.addressviewmodel.typesArrBehaviour) { [weak self] picked in
                self?.addressviewmodel.typeBehaviour.accept(picked)
            }
            
            self.Resistanttype.HandleDoneButton1(vc: self, selector: #selector(self.v))
            
        }).disposed(by: disposebag)
    }
    
    @objc func v(_ sender: Any) {
        Resistanttype.text = addressviewmodel.typeBehaviour.value
        addressviewmodel.ActionForPicked(ShopGroupView, VillaGroudView, aptView: AptView, label: BuildingLabel)
        addressviewmodel.FillAreaList()
        AreaTextField.text = addressviewmodel.AreaBehaviour.value
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Add PickerView to AreaTextField To Chooce number of building.
    func SetAreaToPickerView() {
        
        addressviewmodel.FillAreaList()
        
        AreaTextField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SetDataToPikcerView(self.AreaTextField, self.addressviewmodel.AreaArrBehaviour) { [weak self] picked in
                self?.addressviewmodel.AreaBehaviour.accept(picked)
            }
            
            self.AreaTextField.HandleDoneButton1(vc: self, selector: #selector(self.A))
        }).disposed(by: disposebag)
    }
    @objc func A(_ sender: Any) {
        AreaTextField.text = addressviewmodel.AreaBehaviour.value
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- This Method For Set Group PickerView to GroupTextField.
    func SetGroupTextFieldToPickerView() {
        
        addressviewmodel.FillGroup()
        
        GroupNumber.rx.controlEvent(.editingDidBegin).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SetDataToPikcerView(self.GroupNumber, self.addressviewmodel.groupArrBehaviour) { [weak self] picked in
                self?.addressviewmodel.groupBehaviour.accept(picked)
            }
            
            self.GroupNumber.HandleDoneButton1(vc: self, selector: #selector(self.G))
            
        }).disposed(by: disposebag)
        
    }
    @objc func G(_ sender: Any) {
        GroupNumber.text = addressviewmodel.groupBehaviour.value
    }
    // ------------------------------------------------
    
    // MARK:- TODO:- Action to Next Button to Make Action.
    func SetNextToShopName() {
        ShopName.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.AddressTextField.becomeFirstResponder()
        }).disposed(by: disposebag)
    }
    
    func SetNextToAddress() {
        AddressTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.AddressTextField.resignFirstResponder()
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
    
    // MARK:- TODO:- Add Next Button Action to Button
    func SubscribeToNextButton() {
        NextButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            
            let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "infromationViewController") as! infromationViewController
            nextVc.modalPresentationStyle = .fullScreen
            
            self.present(nextVc, animated: true)
            
        }).disposed(by: disposebag)
    }
    // ------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
