//
//  OrderDetailsViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 01/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class OrderDetailsViewModel {
    var productsBehaviour = BehaviorRelay<[ProductModel]>(value: [])
    
    func LoadProductsOperation(_ order: OrderModel) {
        productsBehaviour.accept(order.products)
    }
}
