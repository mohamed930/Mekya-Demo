//
//  FavouriteViewController.swift
//  Mekyal
//
//  Created by Mohamed Ali on 28/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SearchTextField: UITextField!
    
    let cellIdentifier = "Cell"
    let cellNibFile = "ProductCollectionViewCell"
    let favouriteviewmodel = FavouriteViewModel()
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        SearchTextField.setPadding(paddingValue: 42, PlaceHolder: "SearchPlaceHolder".localized, Color: UIColor().hexStringToUIColor(hex: "#9F9A9A"))
        BindToTextField()
        HandleReturnForSeatchTextFiedl()
        ResposnseSearchEmpty()
        RegesterCollectionView()
        BindToCollectionView()
        SubscribeToCellButtonAction()
        LoadFavourite()
    }
    
    func BindToTextField() {
        SearchTextField.rx.text.orEmpty.bind(to: favouriteviewmodel.SearchBehaviour).disposed(by: disposebag)
        
        let queryResult = SearchTextField.rx.text.orEmpty
           .throttle(.microseconds(300), scheduler: MainScheduler.instance)
           .distinctUntilChanged()
           .map ({ query in
               self.favouriteviewmodel.favourtiesBehaviour.value.filter { user in
                   query.isEmpty || user.ProductName.lowercased().contains(query.lowercased())
               }
           })

           queryResult.asObservable().subscribe(onNext: { [weak self] usermodel in
            
               guard let self = self else { return }
            
            self.favouriteviewmodel.favourtiesBehaviour.accept(usermodel)
           }).disposed(by: disposebag)
    }
    
    func HandleReturnForSeatchTextFiedl() {
        SearchTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.SearchTextField.resignFirstResponder()
            
        }).disposed(by: disposebag)
    }
    
    func ResposnseSearchEmpty() {
            
        favouriteviewmodel.isSearchBehaviour.asObservable().subscribe(onNext: { [weak self] action in
            
            guard let self = self else { return }
            
            if action {
                print("TextField is Empty")
                self.favouriteviewmodel.favourtiesBehaviour.accept(self.favouriteviewmodel.BackupFavouritesBehaviour.value)
            }
//            else {
//                if self.favouriteviewmodel.favourtiesBehaviour.value.isEmpty {
//
//                }
//            }
            
        }).disposed(by: disposebag)
        
    }
    
    func RegesterCollectionView() {
        collectionView.register(UINib(nibName: cellNibFile, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        
        let size = Int(((collectionView.frame.size.width - 10) / CGFloat(3)))
        
        flowLayout.itemSize = CGSize(width: size, height: 113)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
                
        collectionView.collectionViewLayout = flowLayout
    }
    
    func BindToCollectionView() {
        favouriteviewmodel.favourtiesBehaviour.bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier, cellType: ProductCollectionViewCell.self)){ row , branch , cell in
            
            cell.ConfigureCell(branch)
        }.disposed(by: disposebag)
    }
    
    func SubscribeToCellButtonAction() {
        // Bind Selected Item.
        Observable
            .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(ProductModel.self))
            .bind { [weak self] selectedIndex, branch in

                    guard let self = self else { return }
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
                nextVC.productmodel = branch
                nextVC.modalPresentationStyle = .fullScreen
                
                self.present(nextVC, animated: true)
            }.disposed(by: disposebag)
    }
    
    func LoadFavourite() {
        favouriteviewmodel.LoadFavouriteOperation()
    }
    

}
