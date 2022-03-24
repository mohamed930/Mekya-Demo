//
//  CartViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 28/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NoteTextField: UITextField!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var DeliveryLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    let cartviewmodel = CartViewModel()
    let disposebag    = DisposeBag()
    let cellIdentifier = "Cell"
    let cellNibFileName = "CartTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subtotalLabel.SetDirection()
        DeliveryLabel.SetDirection()
        totalLabel.SetDirection()
        
        NoteTextField.setPadding(paddingValue: 52, PlaceHolder: "NotePlaceHolder".localized , Color: UIColor.black)
        SetActionToDoneButtonInNoteTextField()
        BindToNoteTextField()
        checkoutButton.SetCornerRadious()
        RegesterTableView()
        BindTotableView()
        LoadCartData()
        
        SubscribeToSubTotal()
    }
    
    func BindToNoteTextField() {
        NoteTextField.rx.text.orEmpty.bind(to: cartviewmodel.noteBehaviour).disposed(by: disposebag)
    }
    
    func SetActionToDoneButtonInNoteTextField() {
        NoteTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.cartviewmodel.AddNoteOperation()
            self.NoteTextField.resignFirstResponder()
            
        }).disposed(by: disposebag)
    }
    
    func RegesterTableView() {
        tableView.register(UINib(nibName: cellNibFileName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.rowHeight = 65.0
    }
    
    func BindTotableView() {
        cartviewmodel.productBehaviour.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: CartTableViewCell.self)) { row, branch , cell in
            
            cell.ConfigureCell(productModel: branch, cartviewmodel: self.cartviewmodel)
            
            cell.AddButtonObserval.subscribe(onNext: { _ in
                self.cartviewmodel.AddAmountOperation(branch, cell)
            }).disposed(by: cell.disposeBag)
                
            cell.MinusButtonObserval.subscribe(onNext: { _ in
                self.cartviewmodel.MinusAmountOperation(branch, cell)
            }).disposed(by: cell.disposeBag)
           
            cell.DeleteButtonObserval.subscribe(onNext: { _ in
                self.cartviewmodel.removeItem(at: IndexPath(row: row, section: 0))
                
                if let tabItems = self.tabBarController?.tabBar.items {
                    // In this case we want to modify the badge number of the second tab:
                    let tabItem = tabItems[1]
                    if self.cartviewmodel.productBehaviour.value.count == 0 {
                        tabItem.badgeValue = nil
                    }
                    else {
                        tabItem.badgeValue = "\(self.cartviewmodel.productBehaviour.value.count)"
                    }
                    
                }
            }).disposed(by: cell.disposeBag)
            
        }.disposed(by: disposebag)
    }
    
    func LoadCartData() {
        cartviewmodel.LoadDataOperation()
    }
    
    func SubscribeToSubTotal() {
        cartviewmodel.totalBehaviour.subscribe(onNext: { [weak self] total in
            self?.subtotalLabel.text = total
            
            self?.DeliveryLabel.text = "10.0"
            
            let t = Double(total)! + 10.0
            
            self?.totalLabel.text = "\(t)"
            
        }).disposed(by: disposebag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
