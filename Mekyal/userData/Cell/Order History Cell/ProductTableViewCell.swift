//
//  ProductTableViewCell.swift
//  Mekyal
//
//  Created by Mohamed Ali on 31/01/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AmountView: UIView!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var ProductPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        AmountView.SetCornerRadious(cornerRadious: 5, color: "#D8DAE0")
    }

    func ConfigureCell(_ product: ProductModel) {
        AmountLabel.text = product.ProductAmout + "x"
        productimage.image = UIImage(named: product.productImage)
        if product.producttype == "KG" {
            ProductNameLabel.text = product.ProductName + "(\(product.producttype.localized))"
        }
        else {
            ProductNameLabel.text = product.ProductName + "(\("PCs".localized))"
        }
        
        ProductPriceLabel.text = product.productPrice + " " + "EGP".localized
    }
    
}
