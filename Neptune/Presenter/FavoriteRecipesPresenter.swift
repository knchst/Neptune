//
//  FavoriteRecipesPresenter.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import RealmSwift
@testable import Neptune

protocol FavoriteRecipesView: class {
    func showRecipeDetail(id: String)
    func update(deletions: [Int], insertions: [Int])
}

class FavoriteRecipesPresenter {
    let recipes = try! Realm().objects(FavoriteRecipe.self).sorted(byKeyPath: "createdAt", ascending: false)
    private weak var view: FavoriteRecipesView!
    
    init(view: FavoriteRecipesView) {
        self.view = view
    }
    
    func didSelectItem(recipeId: String) {
        self.view?.showRecipeDetail(id: recipeId)
    }
    
    func update(deletions: [Int], insertions: [Int]) {
        self.view?.update(deletions: deletions, insertions: insertions)
    }
}
