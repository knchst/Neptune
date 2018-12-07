//
//  RecipesDataManager.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import RealmSwift
@testable import Neptune

class RecipesDataManager: NSObject {
    private let presenter: RecipesPresenter
    
    init(presenter: RecipesPresenter) {
        self.presenter = presenter
    }
}

// MARK: UICollectionViewDataSource
extension RecipesDataManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: App.Const.RecipeCellIdetifier, for: indexPath) as! RecipeCollectionViewCell
        let recipe = self.presenter.recipes[indexPath.row]
        cell.titleLabel.attributedText = recipe.attributedTitle
        cell.isFavorited = recipe.isFavorited
        cell.recipeImageView.kf.setImage(with: URL(string: recipe.thumbnailSquareUrl)!, options: [.transition(.fade(1))])
        cell.onFavoriteBtnTapped = { [weak self] in
            let isFavorited = recipe.toggleFavorite()
            cell.isFavorited = isFavorited
            if isFavorited {
                cell.animateFavoriteBtn()
                self?.presenter.recipeFavorited()
            }
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension RecipesDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = self.presenter.recipes[indexPath.row]
        self.presenter.didSelectItem(recipeId: recipe.id)
    }
}
