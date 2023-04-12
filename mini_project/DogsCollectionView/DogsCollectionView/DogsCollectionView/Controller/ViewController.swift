//
//  ViewController.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var flickrResponse: Flickr?

    fileprivate func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        getImages()
    }
    
    func getImages() {
        
        NetworkAPI.sharedInstance().getImagesByFlickr(tagName: "puppy",
                                                      format: "json" ,
                                                      completionHandler : { [weak self] result in
                                                        
            switch result {
            case .success(let data):
                self?.flickrResponse = data
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                // Check for internal error enum cases
                print("Some error occurred: " + error.localizedDescription)
            }
        })
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        print("Cell tapped")
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrResponse?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier , for: indexPath) as! MyCollectionViewCell
        
        if let currentCell = flickrResponse?.items[indexPath.item] {
            let image = currentCell.media.m
            let name = currentCell.title
            let date = currentCell.published
            cell.configure(with: image, name: name, date: date)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

}

