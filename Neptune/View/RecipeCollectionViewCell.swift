//
//  RecipeCollectionViewCell.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
@testable import Neptune

class RecipeCollectionViewCell: UICollectionViewCell {
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = recipeImageView.bounds
        return gradient
    }()
    
    var onFavoriteBtnTapped: (() -> Void)? = nil
    
    var isFavorited: Bool! {
        didSet {
            if isFavorited {
                favoriteBtn.setImage(UIImage(named: "heart-filled"), for: .normal)
            } else {
                favoriteBtn.setImage(UIImage(named: "heart-outline"), for: .normal)
            }
        }
    }

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeImageView.kf.indicatorType = .activity
        recipeImageView.layer.addSublayer(gradient)
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        guard let onFavoriteBtnTapped = self.onFavoriteBtnTapped else { return }
        onFavoriteBtnTapped()
    }
    
    func animateFavoriteBtn() {
        NPTAnimation.pop(view: favoriteBtn, duration: 0.3, delay: 0)
    }
}
