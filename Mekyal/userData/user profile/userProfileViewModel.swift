//
//  userProfileViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 04/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class userProfileViewModel {
    
    var textFieldBehaviour = BehaviorRelay<String>(value: "")
    var disposebag = DisposeBag()
    
    let nationalitiesBehaviour = BehaviorRelay<[String]>(value: [])
    let pickedNationalityBehaviour = BehaviorRelay<String>(value: "")
    
    let AgesBehaviour = BehaviorRelay<[String]>(value: [])
    let pickedAgeBehaviour = BehaviorRelay<String>(value: "")
    
    var logoutOperation = BehaviorRelay<Bool?>(value: nil)
    
    func fillNationality() {
        let arr = ["Afghan",
                   "Albanian",
                   "Algerian",
                   "American",
                   "Andorran",
                   "Angolan",
                   "Antiguans",
                   "Argentinean",
                   "Armenian",
                   "Australian",
                   "Austrian",
                   "Azerbaijani",
                   "Bahamian",
                   "Bahraini",
                   "Bangladeshi",
                   "Barbadian",
                   "Barbudans",
                   "Batswana",
                   "Belarusian",
                   "Belgian",
                   "Belizean",
                   "Beninese",
                   "Bhutanese",
                   "Bolivian",
                   "Bosnian",
                   "Brazilian",
                   "British",
                   "Bruneian",
                   "Bulgarian",
                   "Burkinabe",
                   "Burmese",
                   "Burundian",
                   "Cambodian",
                   "Cameroonian",
                   "Canadian",
                   "Cape Verdean",
                   "Central African",
                   "Chadian",
                   "Chilean",
                   "Chinese",
                   "Colombian",
                   "Comoran",
                   "Congolese",
                   "Costa Rican",
                   "Croatian",
                   "Cuban",
                   "Cypriot",
                   "Czech",
                   "Danish",
                   "Djibouti",
                   "Dominican",
                   "Dutch",
                   "East Timorese",
                   "Ecuadorean",
                   "Egyptian",
                   "Emirian",
                   "Equatorial Guinean",
                   "Eritrean",
                   "Estonian",
                   "Ethiopian",
                   "Fijian",
                   "Filipino",
                   "Finnish",
                   "French",
                   "Gabonese",
                   "Gambian",
                   "Georgian",
                   "German",
                   "Ghanaian",
                   "Greek",
                   "Grenadian",
                   "Guatemalan",
                   "Guinea-Bissauan",
                   "Guinean",
                   "Guyanese",
                   "Haitian",
                   "Herzegovinian",
                   "Honduran",
                   "Hungarian",
                   "I-Kiribati",
                   "Icelander",
                   "Indian",
                   "Indonesian",
                   "Iranian",
                   "Iraqi",
                   "Irish",
                   "Israeli",
                   "Italian",
                   "Ivorian",
                   "Jamaican",
                   "Japanese",
                   "Jordanian",
                   "Kazakhstani",
                   "Kenyan",
                   "Kittian and Nevisian",
                   "Kuwaiti",
                   "Kyrgyz",
                   "Laotian",
                   "Latvian",
                   "Lebanese",
                   "Liberian",
                   "Libyan",
                   "Liechtensteiner",
                   "Lithuanian",
                   "Luxembourger",
                   "Macedonian",
                   "Malagasy",
                   "Malawian",
                   "Malaysian",
                   "Maldivan",
                   "Malian",
                   "Maltese",
                   "Marshallese",
                   "Mauritanian",
                   "Mauritian",
                   "Mexican",
                   "Micronesian",
                   "Moldovan",
                   "Monacan",
                   "Mongolian",
                   "Moroccan",
                   "Mosotho",
                   "Motswana",
                   "Mozambican",
                   "Namibian",
                   "Nauruan",
                   "Nepalese",
                   "New Zealander",
                   "Nicaraguan",
                   "Nigerian",
                   "Nigerien",
                   "North Korean",
                   "Northern Irish",
                   "Norwegian",
                   "Omani",
                   "Pakistani",
                   "Palauan",
                   "Panamanian",
                   "Papua New Guinean",
                   "Paraguayan",
                   "Peruvian",
                   "Polish",
                   "Portuguese",
                   "Qatari",
                   "Romanian",
                   "Russian",
                   "Rwandan",
                   "Saint Lucian",
                   "Salvadoran",
                   "Samoan",
                   "San Marinese",
                   "Sao Tomean",
                   "Saudi",
                   "Scottish",
                   "Senegalese",
                   "Serbian",
                   "Seychellois",
                   "Sierra Leonean",
                   "Singaporean",
                   "Slovakian",
                   "Slovenian",
                   "Solomon Islander",
                   "Somali",
                   "South African",
                   "South Korean",
                   "Spanish",
                   "Sri Lankan",
                   "Sudanese",
                   "Surinamer",
                   "Swazi",
                   "Swedish",
                   "Swiss",
                   "Syrian",
                   "Taiwanese",
                   "Tajik",
                   "Tanzanian",
                   "Thai",
                   "Togolese",
                   "Tongan",
                   "Trinidadian/Tobagonian",
                   "Tunisian",
                   "Turkish",
                   "Tuvaluan",
                   "Ugandan",
                   "Ukrainian",
                   "Uruguayan",
                   "Uzbekistani",
                   "Venezuelan",
                   "Vietnamese",
                   "Welsh",
                   "Yemenite",
                   "Zambian",
                   "Zimbabwean"]
        nationalitiesBehaviour.accept(arr)
    }
    
    func FillAges() {
        let arr = ["0-20","21-40","41-60","More > 60"]
        AgesBehaviour.accept(arr)
    }
    
    func AddTextFieldToAlertOperation(title: String , message: String,ob: UIViewController , placeHolder: String , keytype: UIKeyboardType ,completion: @escaping (Bool) -> ()) {
        
        var textField = UITextField()
               
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "update".localized, style: .default) { _ in
            completion(true)
        }
        
        alert.addTextField { [weak self] (alertTextField) in
            guard let self = self else { return }
            
            alertTextField.placeholder = placeHolder
            alertTextField.keyboardType = keytype
            textField = alertTextField
            textField.rx.text.orEmpty.bind(to: self.textFieldBehaviour).disposed(by: self.disposebag)
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        
        ob.present(alert, animated: true)
        
    }
    
    func AddGuester (view: UIImageView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposebag)
    }
    
    func AddGuester (view: UIStackView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposebag)
    }
    
    func LogoutOperation() {
        logoutOperation.accept(true)
    }
    
}
