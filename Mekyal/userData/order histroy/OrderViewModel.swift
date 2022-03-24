//
//  OrderViewModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 30/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class OrderViewModel {
    var ordersBehaviour = BehaviorRelay<[OrderModel]>(value: [])
    
    func LoadDataOperation() {
        var arr = Array<OrderModel>()
        var products = Array<ProductModel>()
        
        var p = ProductModel(ProductName: "Red Onion", productImage: "Product(2)", productPrice: "15", productRate: "3", producttype: "KG", ProductFav: false, ProductInCart: true, ProductAmout: "3")
        products.append(p)
        
        p = ProductModel(ProductName: "Genuin", productImage: "Product(1)", productPrice: "5", productRate: "3", producttype: "Piece", ProductFav: false, ProductInCart: true, ProductAmout: "5")
        products.append(p)
        
        
        var order = OrderModel(date: "Fri,30 Dec 2021", time: "10:00 AM", id: "3", orderImageurl: "Product(1)", orderstatus: "Canceled", rate: "4", paycase: "Cash On Delivery", shippedAddress: "Port said , portfouad streat 23 at school", subtotalPrice: "25.0", DeliveryCoast: "15.0", totalPrice: "40.0", products: products)
        
        arr.append(order)
        
        order = OrderModel(date: "Fri,30 Dec 2021", time: "11:30 AM", id: "2", orderImageurl: "Product(1)", orderstatus: "Delivering", rate: "2", paycase: "Cash On Delivery", shippedAddress: "Port said , portfouad streat 23 at school", subtotalPrice: "70.0", DeliveryCoast: "20.0", totalPrice: "90.0", products: products)
        arr.append(order)
        
        order = OrderModel(date: "Fri,30 Dec 2021", time: "01:30 PM", id: "1", orderImageurl: "Product(1)", orderstatus: "Deliverd", rate: "1", paycase: "Cash On Delivery", shippedAddress: "Port said , portfouad streat 23 at school", subtotalPrice: "40.0", DeliveryCoast: "20.0", totalPrice: "60.0", products: products)
        arr.append(order)
        
        order = OrderModel(date: "Fri,31 Dec 2021", time: "05:30 PM", id: "1", orderImageurl: "Product(1)", orderstatus: "Order placed", rate: "5" , paycase: "Cash On Delivery", shippedAddress: "Port said , portfouad streat 23 at school", subtotalPrice: "14.0", DeliveryCoast: "20.0", totalPrice: "34.0", products: products)
        arr.append(order)
        
        ordersBehaviour.accept(arr)
    }
}
