//
//  FavoriteRecipesViewMock.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
@testable import Neptune

class FavoriteRecipesViewMock: FavoriteRecipesView {
    var isUpdated = false
    var hasDeletions = false
    var hasInsertions = false
    var recipeDetailShowed = false
    
    func update(deletions: [Int], insertions: [Int]) {
        self.isUpdated = true
        self.hasDeletions = deletions.count > 0
        self.hasInsertions = insertions.count > 0
    }
    
    func showRecipeDetail(id: String) {
        self.recipeDetailShowed = true
    }
}
