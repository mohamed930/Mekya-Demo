//
//  OrderDetailsViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 31/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var OrderDateLabel: UILabel!
    @IBOutlet weak var OrderTimeLabel: UILabel!
    
    @IBOutlet weak var OrderStatusLabel: UILabel!
    @IBOutlet weak var OrderStautsView: UIView!
    
    @IBOutlet weak var OrderCashTypeLabel: UILabel!
    @IBOutlet weak var OrderTotalCoastLabel: UILabel!
    
    @IBOutlet weak var OrderAddressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var subtotalPriceLabel: UILabel!
    @IBOutlet weak var DeliveryPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var trackyourOrder: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    let cellIdentifier = "Cell"
    let cellNibFileName = "ProductTableViewCell"
    var OrderDetailsModel: OrderModel!
    let orderdetailsviewmodel = OrderDetailsViewModel()
    let disposebag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        BackButton.CheckButtonDirectory()
        
        OrderStautsView.SetViewBorderCircle()
        trackyourOrder.SetCornerRadious()
        BindToBackButton()
        
        RegesterTableView()
        BindToTableView()
        LoadOrderData()
    }
    
    func BindToBackButton() {
        BackButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposebag)
    }
    
    func RegesterTableView() {
        tableView.register(UINib(nibName: cellNibFileName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = tableView.frame.size.height / 3
    }
    
    func BindToTableView() {
        orderdetailsviewmodel.productsBehaviour.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: ProductTableViewCell.self)) { row , branch , cell in
            cell.ConfigureCell(branch)
        }.disposed(by: disposebag)
    }
    
    func LoadOrderData() {
        
        subtotalPriceLabel.SetDirection()
        DeliveryPriceLabel.SetDirection()
        totalPriceLabel.SetDirection()
        
        OrderDateLabel.text        = OrderDetailsModel.date
        OrderTimeLabel.text        = OrderDetailsModel.time
        OrderStatusLabel.text      = OrderDetailsModel.orderstatus
        OrderCashTypeLabel.text    = OrderDetailsModel.paycase
        OrderTotalCoastLabel.text  = OrderDetailsModel.totalPrice + " " + "EGP".localized
        OrderAddressLabel.text     = OrderDetailsModel.shippedAddress
        subtotalPriceLabel.text    = OrderDetailsModel.subtotalPrice
        DeliveryPriceLabel.text    = OrderDetailsModel.DeliveryCoast
        totalPriceLabel.text       = OrderDetailsModel.totalPrice
        
        if OrderDetailsModel.orderstatus == "Canceled" {
            trackyourOrder.isHidden = true
        }
        else if OrderDetailsModel.orderstatus == "Order placed" {
            trackyourOrder.isHidden = false
            trackyourOrder.setTitle("Cancel".localized, for: .normal)
        }
        else if OrderDetailsModel.orderstatus == "Delivering" {
            trackyourOrder.isHidden = false
            trackyourOrder.setTitle("track".localized, for: .normal)
        }
        else {
            trackyourOrder.isHidden = true
        }
        
        orderdetailsviewmodel.LoadProductsOperation(OrderDetailsModel)
    }
}
