//
//  RecipeDetailPresenter.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
@testable import Neptune

protocol RecipeDetailView: class {
    func fetchStarted()
    func fetchFinished()
    func fetchSuccess()
    func fetchFailure(error: String)
    func showInDevelopment()
}

class RecipeDetailPresenter {
    private weak var view: RecipeDetailView!
    var recipe: RecipeDetail!
    var id: String!
    var service: RecipeDetailServiceable!
    
    init(view: RecipeDetailView, id: String) {
        self.view = view
        self.id = id
        self.service = RecipeDetailService(id: self.id)
    }
    
    @objc func fetch() {
        self.view?.fetchStarted()
        self.service.fetchRecipe(completion: { [weak self] result in
            self?.view?.fetchFinished()
            switch result {
            case .success(let recipe):
                self?.recipe = recipe
                self?.view?.fetchSuccess()
            case .failure(let error):
                self?.view?.fetchFailure(error: error.localizedDescription)
            }
        })
    }
    
    func showInDevelopment() {
        self.view?.showInDevelopment()
    }
}
