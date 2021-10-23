//
//  ViewController.swift
//  Swift VK
//
//  Created by Stanislav Briver on 19.10.2021.
//

import UIKit
//import RxSwift
//import RxCocoa


class ImageCollectionView: UICollectionViewController {
    
//    let imageViewModel = ImageViewModel()
      let imageViewModel = WebImageViewModel()
    
    
    let customRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
//    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imageObservable = Observable.just(imageViewModel.imageArray)
//        imageObservable.bind(to: collectionView.rx.items(cellIdentifier: "ImageCell", cellType: ImageCell.self) {_, viewModel, cell in
//            
//        }
//
        imageViewModel.loadDataFromResource()
        self.collectionView.refreshControl = customRefreshControl
        self.collectionView?.backgroundColor = .black
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageViewModel.results.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let count = self.imageViewModel.results.count
        
        if indexPath.row < count {
            cell.data = self.imageViewModel.results[indexPath.row]
        }
        
        cell.backgroundColor = .blue
        return cell
    }
}



extension ImageCollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 2) / 3 , height: (view.frame.width - 2) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}



extension ImageCollectionView{
    
    @objc func didRefresh(_ sender: UIRefreshControl){
        collectionView.reloadData()
        print("reloadData")
        print(imageViewModel.results)
        self.customRefreshControl.endRefreshing()
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(image)


        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    



  
    
}







