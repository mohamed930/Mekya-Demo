//
//  FavouriteViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 28/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class FavouriteViewModel {
    var SearchBehaviour = BehaviorRelay<String>(value: "")
    var favourtiesBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    var BackupFavouritesBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    var SearchedBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    
    // MARK:- TODO:- Make Validation Oberval here.
    var isSearchBehaviour : Observable<Bool> {
        return SearchBehaviour.asObservable().map { search -> Bool in
            let isSearchEmpty = search.trimmingCharacters(in: .whitespaces).isEmpty
            
            return isSearchEmpty
        }
    }
    
    func LoadFavouriteOperation() {
        
        var arr = Array<ProductModel>()
        var products = ProductModel(ProductName: "Ginger", productImage: "Product(1)", productPrice: "125", productRate: "4", producttype: "KG", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "KG", ProductFav: true, ProductInCart: true, ProductAmout: "5.25")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "KG", ProductFav: true, ProductInCart: false, ProductAmout: "3")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "3", producttype: "Piece", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60" , productRate: "2", producttype: "Piece", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        self.favourtiesBehaviour.accept(arr)
        self.BackupFavouritesBehaviour.accept(arr)
        
    }
    
    
}
