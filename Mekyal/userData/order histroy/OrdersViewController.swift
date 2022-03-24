//
//  OrdersViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 29/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "Cell"
    let cellNibFileName = "OrderTableViewCell"
    let orderviewmodel = OrderViewModel()
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BackButton.CheckButtonDirectory()
        RegesterTableView()
        BindToTableView()
        SubscribeToCellButtonAction()
        LoadOrders()
        
        BindToBackButton()
    }
    
    func RegesterTableView() {
        tableView.register(UINib(nibName: cellNibFileName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 95.0
//        tableView.sectionHeaderHeight = 45.0
    }
    
    func BindToTableView() {
        orderviewmodel.ordersBehaviour.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: OrderTableViewCell.self)) {  row, branch, cell in
            cell.configureCell(branch)
            
            let verticalPadding: CGFloat = 20

            let maskLayer = CALayer()
            maskLayer.cornerRadius = 7    //if you want round edges
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: self.tableView.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/3)
            cell.layer.mask = maskLayer
        }.disposed(by: disposebag)
    }
    
    func SubscribeToCellButtonAction() {
        // Bind Selected Item.
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(OrderModel.self))
            .bind { [weak self] selectedIndex, branch in

                    guard let self = self else { return }
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
                nextVC.OrderDetailsModel = branch
                nextVC.modalPresentationStyle = .fullScreen
                
                self.present(nextVC, animated: true)
            }.disposed(by: disposebag)
    }
    
    func LoadOrders() {
        orderviewmodel.LoadDataOperation()
    }
    
    func BindToBackButton() {
        BackButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposebag)
    }

}
