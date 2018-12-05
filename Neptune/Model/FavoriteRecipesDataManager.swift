//
//  FavoriteRecipesDataManager.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import RealmSwift
@testable import Neptune

class FavoriteRecipesDataManager: NSObject {
    private var presenter: FavoriteRecipesPresenter
    var favoriteRecipesNotificationToken: NotificationToken?
    
    init(presenter: FavoriteRecipesPresenter) {
        self.presenter = presenter
    }
    
    func setup() {
        self.favoriteRecipesNotificationToken = self.presenter.recipes.observe { [weak self] changes in
            switch changes {
            case .initial: break
            case .update(_, let deletions, let insertions, _):
                self?.presenter.update(deletions: deletions, insertions: insertions)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    deinit {
        self.favoriteRecipesNotificationToken?.invalidate()
    }
}

// MARK: UICollectionViewDataSource
extension FavoriteRecipesDataManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: App.Const.RecipeCellIdetifier, for: indexPath) as! RecipeCollectionViewCell
        let recipe = self.presenter.recipes[indexPath.row]
        cell.titleLabel.attributedText = recipe.attributedTitle
        cell.recipeImageView.kf.setImage(with: URL(string: recipe.thumbnailSquareUrl)!, options: [.transition(.fade(1))])
        cell.onFavoriteBtnTapped = nil
        cell.favoriteBtn.isHidden = true
        cell.isFavorited = false
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension FavoriteRecipesDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = self.presenter.recipes[indexPath.row]
        self.presenter.didSelectItem(recipeId: recipe.id)
    }
}
