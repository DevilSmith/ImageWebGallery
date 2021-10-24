//
//  ViewController.swift
//  Swift VK
//
//  Created by Stanislav Briver on 19.10.2021.
//

import UIKit


protocol ImageCollectionViewUpdateDelegate {
    
    func updateCollectionView()->Void
    
    var collectionView: UICollectionView! {get set}
    
}


class ImageCollectionView: UICollectionViewController {
    
      
    let imageViewPresenter = WebImagePresenter()
     
    var updateDelegate: ImageCollectionViewUpdateDelegate?
    
    var sizeCell: CGSize!
    
    
    
    let customRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let searchController = UISearchController()
        self.navigationItem.searchController = searchController
        

        self.title = "Controller"
        
        
        self.collectionView.contentInset = UIEdgeInsets(top: 100, left: UIScreen().bounds.minX, bottom: 100, right: UIScreen().bounds.maxX)
        
        
        self.sizeCell = CGSize(width: (UIScreen.main.bounds.width - 2) / 3, height: (UIScreen.main.bounds.width - 2) / 3)
        
        
        let zoom = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        self.collectionView.addGestureRecognizer(zoom)
        self.collectionView.isUserInteractionEnabled = true
        
        imageViewPresenter.collectionView = self.collectionView
        self.updateDelegate = imageViewPresenter
        imageViewPresenter.loadDataFromResource()
        self.collectionView.refreshControl = customRefreshControl
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
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



extension ImageCollectionView: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        self.sizeCell = CGSize(width: (view.frame.width - 2) / 3, height: (view.frame.width - 2) / 3)
        return self.sizeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}



extension ImageCollectionView{
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalAxis = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if verticalAxis.y < 0 {
            imageViewPresenter.increaseDataLoading()
        }
    }
    
    
    
    
    @objc func didRefresh(_ sender: UIRefreshControl){
        collectionView.reloadData()
        print("Reload data")
        print(imageViewPresenter.results)
        self.customRefreshControl.endRefreshing()
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer){
        if sender.state == .changed {
            let scale = sender.scale
            print(scale)
            
            if scale > 3 {
                self.sizeCell = CGSize(width: (view.frame.width - 2), height: (view.frame.width - 2))
                self.collectionView.collectionViewLayout.invalidateLayout()
                print(self.sizeCell ?? 0)
            }
            
            if (scale > 1.8) && (scale < 3) {
                self.sizeCell = CGSize(width: (view.frame.width - 2) / 2, height: (view.frame.width - 2) / 2)
                self.collectionView.collectionViewLayout.invalidateLayout()
                print(self.sizeCell ?? 0)
            }
            
            if scale < 1 {
                self.sizeCell = CGSize(width: (view.frame.width - 2) / 3, height: (view.frame.width - 2) / 3)
                self.collectionView.collectionViewLayout.invalidateLayout()
                print(self.sizeCell ?? 0)
            }
        }
    }
    
}

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








