//
//  GridLayout.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    private let spacer: CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let collectionView = self.collectionView else { return }
        let itemWidth: CGFloat = (collectionView.bounds.width / 2) - (spacer / 2)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.minimumLineSpacing = spacer
        self.minimumInteritemSpacing = 0
    }
}
