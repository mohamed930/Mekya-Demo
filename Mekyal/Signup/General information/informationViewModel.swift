//
//  informationViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 17/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class informationViewModel {
    let usernameBehaviour = BehaviorRelay<String>(value: "")
    
    let nationalitiesBehaviour = BehaviorRelay<[String]>(value: [])
    let pickedNationalityBehaviour = BehaviorRelay<String>(value: "")
    
    let AgesBehaviour = BehaviorRelay<[String]>(value: [])
    let pickedAgeBehaviour = BehaviorRelay<String>(value: "")
    
    let pickedGenderBehaviour = BehaviorRelay<String>(value: "")
    let signupResponseBehaviour = BehaviorRelay<String>(value: "")
    
    let disposebag = DisposeBag()
    
    var isNameEnabled : Observable<Bool> {
        return usernameBehaviour.asObservable().map { name -> Bool in
            let isuserNameEmpty = name.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isuserNameEmpty
        }
    }
    
    var isNationalityEnabled : Observable<Bool> {
        return pickedNationalityBehaviour.asObservable().map { natio -> Bool in
            let isNationalityEmpty = natio.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isNationalityEmpty
        }
    }
    
    var isAgeEnabled : Observable<Bool> {
        return pickedAgeBehaviour.asObservable().map { age -> Bool in
            let isAgeEmpty = age.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isAgeEmpty
        }
    }
    
    var isGenderEnabled : Observable<Bool> {
        return pickedGenderBehaviour.asObservable().map { gendre -> Bool in
            let isGendreEmpty = gendre.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isGendreEmpty
        }
    }
    
    var isEnabledSignup: Observable<Bool> {
        return Observable.combineLatest(isNameEnabled,isNationalityEnabled,isAgeEnabled,isGenderEnabled) {
            digitone , digittwo,digitthree,digitfour   in
            let signupValied = !digitone && !digittwo && !digitthree && !digitfour
            
            return signupValied
        }
    }
    
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
    
    func AddGuester (view: UIImageView, completion: @escaping (Bool) -> ()) {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            completion(true)
        }).disposed(by: disposebag)
    }
    
    func Signupoperation() {
        signupResponseBehaviour.accept("Success")
    }
}
