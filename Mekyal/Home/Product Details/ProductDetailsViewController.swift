//
//  ProductDetailsViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 22/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var ProductPriceLabel: UILabel!
    @IBOutlet weak var ProductType: UILabel!
    @IBOutlet weak var ProductAmount: UITextField!
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var AddToCartButton: UIButton!
    @IBOutlet weak var ShopNowButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var MinusButton: UIButton!
    
    var productmodel: ProductModel!
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BackButton.CheckButtonDirectory()
        ShopNowButton.SetBorder()
        AddToCartButton.SetCornerRadious()
        LoadData()
        BindToBackButton()
        BindToAddButton()
        BindToMinusButton()
    }
    
    func BindToBackButton() {
        BackButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposebag)
    }
    
    func LoadData() {
        ProductImageView.image = UIImage(named: productmodel.productImage)
        ProductNameLabel.text = productmodel.ProductName
        ProductPriceLabel.text = "EGP".localized + " " + productmodel.productPrice
        
        if productmodel.producttype == "KG" {
            ProductType.text = "Quantity".localized + " " + "(\(productmodel.producttype.localized))"
        }
        else {
            ProductType.text = "Quantity".localized + " " + "(\("PCs".localized))"
        }
        
        if productmodel.ProductAmout != "" {
            ProductAmount.text = productmodel.ProductAmout
        }
        else {
            ProductAmount.text = "1"
        }
    }
    
    func BindToAddButton() {
        AddButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            if self.productmodel.producttype == "KG" {
                self.ProductAmount.text = "\(Double(self.ProductAmount.text!)! + 0.25)"
            }
            else {
                self.ProductAmount.text = "\(Int(self.ProductAmount.text!)! + 1)"
            }
            
        }).disposed(by: disposebag)
    }
    
    func BindToMinusButton() {
        MinusButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            if self.productmodel.producttype == "KG" {
                if self.ProductAmount.text! == "0.25" {
                    self.ProductAmount.text = "0.25"
                }
                else {
                    self.ProductAmount.text = "\(Double(self.ProductAmount.text!)! - 0.25)"
                }
            }
            else {
                if self.ProductAmount.text == "1" {
                    self.ProductAmount.text = "1"
                }
                else {
                    self.ProductAmount.text = "\(Int(self.ProductAmount.text!)! - 1)"
                }
            }
            
        }).disposed(by: disposebag)
    }
    
}
