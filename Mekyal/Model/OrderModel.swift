//
//  OrderModel.swift
//  Mekyal
//
//  Created by Mohamed Ali on 29/01/2022.
//

import Foundation


struct OrderModel {
    var date: String
    var time: String
    var id: String
    var orderImageurl: String
    var orderstatus: String
    var rate: String
    var paycase: String
    var shippedAddress: String
    var subtotalPrice: String
    var DeliveryCoast: String
    var totalPrice: String
    var products: [ProductModel]
}
