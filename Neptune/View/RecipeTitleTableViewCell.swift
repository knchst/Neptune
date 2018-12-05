//
//  RecipeTitleTableViewCell.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class RecipeTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.layer.cornerRadius = 3
            favoriteButton.layer.borderWidth = 1
            favoriteButton.layer.borderColor = App.Const.lightGlayColor.cgColor
            favoriteButton.setTitleColor(App.Const.darkColor, for: .normal)
            favoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            favoriteButton.imageView?.contentMode = .scaleAspectFit
            favoriteButton.imageView?.tintColor = App.Const.darkColor
            favoriteButton.setImage(UIImage(imageLiteralResourceName: "heart-outline").withRenderingMode(.alwaysTemplate), for: .normal)
            favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8)
        }
    }
    
    var onFavoriteBtnTapped: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        guard let onFavoriteBtnTapped = self.onFavoriteBtnTapped else { return }
        onFavoriteBtnTapped()
    }
}
