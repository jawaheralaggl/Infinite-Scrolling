//
//  ViewController.swift
//  infinite
//
//  Created by Jawaher Alagel on 8/7/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageCollection: [UIImage] = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3")]
    private var numberOfItem: Int = 1000
    var currentX: CGFloat = 0.0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 150)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageView.numberOfPages = imageCollection.count
        pageView.currentPage = 0
        pageView.currentPageIndicatorTintColor = .black
        pageView.pageIndicatorTintColor = .lightGray
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentX > scrollView.contentOffset.x {
            let pageToJump = floor((currentX - scrollView.contentOffset.x) / collectionView.frame.width)
            if pageToJump == 0 {return}
            else {
                currentX -= pageToJump * collectionView.frame.width
            }
            
            let dif = pageView.currentPage - Int(pageToJump)
            if dif > 0 {
                pageView.currentPage = dif
            }else if dif < 0 {
                pageView.currentPage = imageCollection.count + dif
            }else {
                pageView.currentPage = 0
            }
        }else if currentX < scrollView.contentOffset.x {
            let pageToJump = floor((scrollView.contentOffset.x - currentX) / collectionView.frame.width)
            if pageToJump == 0 {return}
            else {
                currentX += pageToJump * collectionView.frame.width
            }
            pageView.currentPage = (pageView.currentPage + Int(pageToJump)) % imageCollection.count
        }
    }
    
    
}


extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tapped")
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return imageCollection.count * 4
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.configure(with: imageCollection[indexPath.row % imageCollection.count])
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var offset = collectionView.contentOffset
        let width = collectionView.contentSize.width
        if offset.x < width/4 {
            offset.x += width/2
            collectionView.setContentOffset(offset, animated: false)
        } else if offset.x > width/4 * 3 {
            offset.x -= width/2
            collectionView.setContentOffset(offset, animated: false)
        }
    }
    
}
