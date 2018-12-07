//
//  RecipesPresenter.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import RealmSwift
@testable import Neptune

protocol RecipesView: class {
    func fetchStarted()
    func fetchFinished()
    func fetchSuccess()
    func fetchFailure(error: String)
    func showRecipeDetail(id: String)
    func recipeFavorited()
}

class RecipesPresenter {
    let recipes = try! Realm().objects(Recipe.self)
    private weak var view: RecipesView!
    var service: RecipesServiceable = RecipesService()
    
    init(view: RecipesView) {
        self.view = view
    }
    
    @objc func fetch() {
        self.view?.fetchStarted()
        self.service.fetchRecipes(completion: { [weak self] result in
            self?.view?.fetchFinished()
            switch result {
            case .success( _):
                self?.view?.fetchSuccess()
            case .failure(let error):
                self?.view?.fetchFailure(error: error.localizedDescription)
            }
        })
    }
    
    func didSelectItem(recipeId: String) {
        self.view?.showRecipeDetail(id: recipeId)
    }
    
    func recipeFavorited() {
        self.view?.recipeFavorited()
    }
}
