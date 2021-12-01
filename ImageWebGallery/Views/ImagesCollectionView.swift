//
//  ViewController.swift
//  ImageWebGallery
//
//  Created by Stanislav Briver on 19.10.2021.
//  Copyright © 2021 Stanislav Briver. All rights reserved.
//

import UIKit

//MARK: - Protocol for delegate for ImageCollection
protocol ImageCollectionViewUpdateDelegate {
    
    func updateCollectionView()->Void
    
    var collectionView: UICollectionView! {get set}
    
}

//MARK: - Class of ImageCollectionView
class ImageCollectionView: UICollectionViewController, UINavigationBarDelegate {
    
    let imageViewPresenter = WebImagePresenter()
     
    var updateDelegate: ImageCollectionViewUpdateDelegate?
    
    var sizeCell: CGSize!
    
    let customRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    func setupSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    func setupNavigationItem(){
        self.title = "Web gallery"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.isTranslucent = true
        self.collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    func setupGestures(){
        let zoom = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        self.collectionView.addGestureRecognizer(zoom)
        self.collectionView.isUserInteractionEnabled = true
    }
    
    func setupDelegate(){
        imageViewPresenter.collectionView = self.collectionView
        self.updateDelegate = imageViewPresenter
        imageViewPresenter.loadDataFromResource(1, "NewYork")
    }
    
    func setupCell(){
        self.sizeCell = CGSize(width: (UIScreen.main.bounds.width - 2) / 3, height: (UIScreen.main.bounds.width - 2) / 3)
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupNavigationItem()
        setupGestures()
        setupDelegate()
        setupCell()
        
        self.collectionView.refreshControl = customRefreshControl

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageViewPresenter.results.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let count = self.imageViewPresenter.results.count
        
        if indexPath.row < count {
            cell.data = self.imageViewPresenter.results[indexPath.row]
        }
        
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - Work with FlowLayout
extension ImageCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//MARK: - Result updating
extension ImageCollectionView: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
///       Real-time searching method:
//        guard let text = searchController.searchBar.text else {return}
//        print(text)
    }
}

//MARK: - Work with SearchBar
extension ImageCollectionView: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        imageViewPresenter.deleteData()
        imageViewPresenter.loadDataFromResource(1, text)
        self.collectionView.reloadData()
    }
}


extension ImageCollectionView{
    
//MARK: - Selecting cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #if DEBUG
        print(indexPath)
        #endif
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let imageView = ImageView(image: imageViewPresenter.results[indexPath.item].image!)
        imageView.modalPresentationStyle = .pageSheet
        
        #if DEBUG
        print(cell.image)
        #endif
        self.present(imageView, animated: true, completion: nil)
        
    }
    
//MARK: - Scrolling cv with async updating
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalAxis = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if verticalAxis.y < 0 {
            imageViewPresenter.increaseDataLoading()
        }
    }
    
    @objc func didRefresh(_ sender: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            #if DEBUG
            print("Reload data")
            print(self.imageViewPresenter.results)
            #endif
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
                self.customRefreshControl.endRefreshing()
            }
        }
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer){
        if sender.state == .changed {
            let scale = sender.scale
            #if DEBUG
            print(scale)
            #endif
            
            if scale > 3 {
                self.sizeCell = CGSize(width: (view.frame.width - 2), height: (view.frame.width - 2))
                self.collectionView.collectionViewLayout.invalidateLayout()
                #if DEBUG
                print(self.sizeCell ?? 0)
                #endif
            }
            
            if (scale > 1.8) && (scale < 3) {
                self.sizeCell = CGSize(width: (view.frame.width - 2) / 2, height: (view.frame.width - 2) / 2)
                self.collectionView.collectionViewLayout.invalidateLayout()
                #if DEBUG
                print(self.sizeCell ?? 0)
                #endif
            }
            
            if scale < 1 {
                self.sizeCell = CGSize(width: (view.frame.width - 2) / 3, height: (view.frame.width - 2) / 3)
                self.collectionView.collectionViewLayout.invalidateLayout()
                #if DEBUG
                print(self.sizeCell ?? 0)
                #endif
            }
        }
    }
}

//MARK: - Cell
class ImageCell: UICollectionViewCell {
    
    var data: ImageModel? {
        didSet {
            guard let data = data else {return}
            image.image = data.image
        }
    }
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(image)

        UIView.animate(withDuration: 0.5) {
            self.image.alpha = 1
        }
        
        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








