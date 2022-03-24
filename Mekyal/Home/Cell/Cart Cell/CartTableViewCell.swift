//
//  CartTableViewCell.swift
//  Mekyal
//
//  Created by Mohamed Ali on 28/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var ProductPriceLabel: UILabel!
    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var MinusButton: UIButton!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var DeleteButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    var AddButtonObserval : Observable<Void>{
        return self.AddButton.rx.tap.throttle(.milliseconds(1000), scheduler: MainScheduler.instance).asObservable()
    }
    
    var MinusButtonObserval : Observable<Void>{
        return self.MinusButton.rx.tap.throttle(.milliseconds(1000), scheduler: MainScheduler.instance).asObservable()
    }
    
    var DeleteButtonObserval : Observable<Void>{
        return self.DeleteButton.rx.tap.throttle(.milliseconds(1000), scheduler: MainScheduler.instance).asObservable()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func ConfigureCell(productModel: ProductModel, cartviewmodel: CartViewModel) {
        ProductImage.image = UIImage(named: productModel.productImage)
        if productModel.producttype == "KG" {
            ProductNameLabel.text = productModel.ProductName + "(\(productModel.producttype.localized))"
        }
        else {
            ProductNameLabel.text = productModel.ProductName + "(\("PCs".localized))"
        }
        
        ProductPriceLabel.text = productModel.productPrice + " " + "EGP".localized
        
        AmountTextField.text = productModel.ProductAmout
    }
}
