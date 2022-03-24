//
//  OrderTableViewCell.swift
//  Mekyal
//
//  Created by Mohamed Ali on 29/01/2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var OrderStatusLabel: UILabel!
    @IBOutlet weak var OrderStatusView: UIView!
    
    @IBOutlet weak var star1:UIImageView!
    @IBOutlet weak var star2:UIImageView!
    @IBOutlet weak var star3:UIImageView!
    @IBOutlet weak var star4:UIImageView!
    @IBOutlet weak var star5:UIImageView!
    
    var arr = Array<UIImageView>()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        arr = [star1,star2,star3,star4,star5]
        OrderStatusView.SetViewBorderCircle()
    }
    
    func configureCell (_ order: OrderModel) {
        orderImage.image = UIImage(named: order.orderImageurl)
        DateLabel.text = order.date
        timeLabel.text = order.time
        IDLabel.text = "ID #" + order.id
        OrderStatusLabel.text = order.orderstatus
        
        switch order.orderstatus {
        case "Order place":
            OrderStatusView.backgroundColor = UIColor().hexStringToUIColor(hex: "#F29339")
        case "Deliverd":
            OrderStatusView.backgroundColor = UIColor().hexStringToUIColor(hex: "#0C0D0D")
        case "Delivering":
            OrderStatusView.backgroundColor = UIColor().hexStringToUIColor(hex: "#3C9514")
        default:
            OrderStatusView.backgroundColor = UIColor().hexStringToUIColor(hex: "#FF5858")
        }
        
        for i in 0..<Int(order.rate)! {
            arr[i].image = UIImage(named: "MarkedStar")
        }
    }
}
