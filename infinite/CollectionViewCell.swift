//
//  CollectionViewCell.swift
//  infinite
//
//  Created by Jawaher Alagel on 8/7/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier =  "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // imageView.layer.cornerRadius = 20
    }
    
    public func configure(with image: UIImage ) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
}
