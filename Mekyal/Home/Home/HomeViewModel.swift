//
//  HomeViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 22/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    var offersBehaviour   = BehaviorRelay<[String]>(value: [])
    var productsBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    var cartBehaviour     = BehaviorRelay<CartModel?>(value: nil)
    
    func GetOffersOperation() {
        let arr = ["offers","offers","offers"]
        
        offersBehaviour.accept(arr)
    }
    
    func GetProductsOperation() {
        var arr = Array<ProductModel>()
        var products = ProductModel(ProductName: "Ginger", productImage: "Product(1)", productPrice: "125", productRate: "4", producttype: "KG", ProductFav: false, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "KG", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "KG", ProductFav: false, ProductInCart: true, ProductAmout: "3")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "3", producttype: "Piece", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60" , productRate: "2", producttype: "Piece", ProductFav: true, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "3", producttype: "Piece", ProductFav: false, ProductInCart: true, ProductAmout: "2")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "3", producttype: "Piece", ProductFav: false, ProductInCart: false, ProductAmout: "")
        
        arr.append(products)
        
        
        productsBehaviour.accept(arr)
        
        let cartModel = CartModel(cartcount: "3", cartAmount: "150")
        cartBehaviour.accept(cartModel)
        
    }
    
    func HandleTapBarTint(_ navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor().hexStringToUIColor(hex: "#D8DAE0")
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
