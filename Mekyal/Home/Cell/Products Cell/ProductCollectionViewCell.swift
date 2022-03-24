//
//  ProductCollectionViewCell.swift
//  Mekyal
//
//  Created by Mohamed Ali on 22/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var LoveButton: UIButton!
    
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ProductType: UILabel!
    
    @IBOutlet weak var AmountView: UIView!
    @IBOutlet weak var AmountLabel: UILabel!
    
    @IBOutlet weak var CellView: UIView!
    
    var disposebag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CellView.SetAllViewShadow()
        AmountView.SetAllViewShadow()
        
    }
    
    func ConfigureCell(_ productmodel: ProductModel) {
        ProductImageView.image = UIImage(named: productmodel.productImage)
        ProductNameLabel.text = productmodel.ProductName
        PriceLabel.text = "EGP".localized + " " + productmodel.productPrice
        if productmodel.producttype == "KG" {
            ProductType.text = "1 " + "KG".localized
        }
        else {
            ProductType.text = "1 " + "PCs".localized
        }
        
        
        if productmodel.ProductInCart == true {
            AmountView.isHidden = false
            if (productmodel.producttype == "KG") {
                AmountLabel.text = productmodel.ProductAmout + " " +  "KG".localized
            }
            else {
                AmountLabel.text = productmodel.ProductAmout + " " + "PCs".localized
            }
            
        }
        else {
            AmountView.isHidden = true
        }
        
        if productmodel.ProductFav == true {
            LoveButton.setBackgroundImage(UIImage(named: "Love"), for: .normal)
        }
        else {
            LoveButton.setBackgroundImage(UIImage(named: "NonLove"), for: .normal)
        }
    }
}
