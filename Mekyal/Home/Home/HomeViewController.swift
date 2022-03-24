//
//  HomeViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 22/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var OffersCollectionView: UICollectionView!
    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    
    @IBOutlet weak var MessageView: UIView!
    @IBOutlet weak var PriceLabel:  UILabel!
    
    let cellIdentifier = "Cell"
    let cellNibFileName = "OffersCollectionViewCell"
    let productNibFileName = "ProductCollectionViewCell"
    let homeviewmodel = HomeViewModel()
    let disposebag    = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchTextField.setPadding(paddingValue: 42, PlaceHolder: "SearchPlaceHolder".localized, Color: UIColor().hexStringToUIColor(hex: "#9F9A9A"))
        SubscribeToLoadCart()
        RegesterToProductsCollectionView()
        BindToProductsCollectionView()
        GetProducts()

        RegesterToOffersCollectionView()
        SubscribeToOffers()
        SubscribeToCellButtonAction()
        GetOffers()
        
    }
    
    func SubscribeToLoadCart() {
        
        homeviewmodel.cartBehaviour.subscribe(onNext: { [weak self] cart in
            guard let self = self else { return }
            
            guard let value = cart else {
                self.MessageView.isHidden = true
                return
            }
            
            if value.cartcount != "" {
                self.MessageView.isHidden = false
                self.PriceLabel.text = value.cartAmount
                
                if let tabItems = self.tabBarController?.tabBar.items {
                    // In this case we want to modify the badge number of the second tab:
                    let tabItem = tabItems[1]
                    tabItem.badgeValue = value.cartcount
                }
            }
            
        }).disposed(by: disposebag)
    }
    
    func RegesterToOffersCollectionView() {
        OffersCollectionView.register(UINib(nibName: cellNibFileName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        OffersCollectionView.tag = 0
        OffersCollectionView.delegate = self
    }
    
    func SubscribeToOffers() {
        homeviewmodel.offersBehaviour.bind(to: OffersCollectionView.rx.items(cellIdentifier: cellIdentifier, cellType: OffersCollectionViewCell.self)) { index, branch, cell in
            cell.offerImageView.image = UIImage(named: branch)
        }.disposed(by: disposebag)
    }
    
    func GetOffers() {
        homeviewmodel.GetOffersOperation()
    }
    
    func RegesterToProductsCollectionView() {
        ProductsCollectionView.register(UINib(nibName: productNibFileName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
//        let size = Int(((ProductsCollectionView.bounds.width) / CGFloat(3.0)))
        
        let w1 = ProductsCollectionView.frame.width - (10 * 3)
        let cell_width = (w1 - (10 * 3)) / 2.5
        
        flowLayout.itemSize = CGSize(width: cell_width, height: 103)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
                
        ProductsCollectionView.collectionViewLayout = flowLayout
    }
    
    func BindToProductsCollectionView() {
        homeviewmodel.productsBehaviour.bind(to: ProductsCollectionView.rx.items(cellIdentifier: cellIdentifier, cellType: ProductCollectionViewCell.self)) {index, branch , cell in
            cell.ConfigureCell(branch)
        }.disposed(by: disposebag)
    }
    
    func SubscribeToCellButtonAction() {
        // Bind Selected Item.
        Observable
            .zip(ProductsCollectionView.rx.itemSelected, ProductsCollectionView.rx.modelSelected(ProductModel.self))
            .bind { [weak self] selectedIndex, branch in

                    guard let self = self else { return }
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                nextVC.productmodel = branch
                nextVC.modalPresentationStyle = .fullScreen
                
                self.present(nextVC, animated: true)
            }.disposed(by: disposebag)
    }
    
    func GetProducts() {
        homeviewmodel.GetProductsOperation()
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = OffersCollectionView.layer.frame.size.width
        let hight = OffersCollectionView.layer.frame.size.height
        
        return CGSize(width: size, height: hight)
    }
}
