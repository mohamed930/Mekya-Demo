//
//  CartViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 28/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CartViewModel {
    
    var noteBehaviour = BehaviorRelay<String>(value: "")
    
    var productBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    var totalBehaviour   = BehaviorRelay<String>(value: "")
    
    func LoadDataOperation() {
        var arr = Array<ProductModel>()
        var products = ProductModel(ProductName: "Ginger", productImage: "Product(1)", productPrice: "125", productRate: "4", producttype: "KG", ProductFav: false, ProductInCart: true, ProductAmout: "3.15")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "Piece", ProductFav: true, ProductInCart: true, ProductAmout: "2")
        
        arr.append(products)
        
        products = ProductModel(ProductName: "Red Onions", productImage: "Product(2)", productPrice: "60", productRate: "4", producttype: "KG", ProductFav: false, ProductInCart: true, ProductAmout: "1")
        
        arr.append(products)
        
        var total = 0.0
        
        for i in arr {
            total += Double(Float(i.ProductAmout)! * Float(i.productPrice)!)
        }
        
        totalBehaviour.accept(String(total))
        
        productBehaviour.accept(arr)
        
    }
    
    func AddAmountOperation(_ branch: ProductModel, _ cell: CartTableViewCell) {
        if (branch.producttype == "KG") {
            let value = Double(cell.AmountTextField.text!)! + 0.25
            cell.AmountTextField.text = String(value)
        }
        else {
            let value = Int(cell.AmountTextField.text!)! + 1
            cell.AmountTextField.text = String(value)
        }
    }
    
    func MinusAmountOperation(_ branch: ProductModel, _ cell: CartTableViewCell) {
        if (branch.producttype == "KG") {
            if Double(cell.AmountTextField.text!)! <= 0.25 {
                cell.AmountTextField.text = "0.25"
            }
            else {
                let value = Double(cell.AmountTextField.text!)! - 0.25
                cell.AmountTextField.text = String(value)
            }
        }
        else {
            if cell.AmountTextField.text == "1" {
                cell.AmountTextField.text = "1"
            }
            else {
                let value = Int(cell.AmountTextField.text!)! - 1
                cell.AmountTextField.text = String(value)
            }
        }
    }
    
    func removeItem(at indexPath: IndexPath) {
        var sections = productBehaviour.value
        
        sections.remove(at: indexPath.row)

        productBehaviour.accept(sections)
    }
    
    func AddNoteOperation() {
        
    }
}
