//
//  RecipesViewMock.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation

class RecipesViewMock: RecipesView {
    var isFetchStarted = false
    var isFetchFinished = false
    var isFetchSuccess = false
    var isFetchFailure = false
    var isShowRecipeDetail = false
    var isRecipeFavorited = false
    
    func fetchStarted() {
        self.isFetchStarted = true
    }
    
    func fetchFinished() {
        self.isFetchFinished = true
    }
    
    func fetchSuccess() {
        self.isFetchSuccess = true
    }
    
    func fetchFailure(error: String) {
        self.isFetchFailure = true
    }
    
    func showRecipeDetail(id: String) {
        self.isShowRecipeDetail = true
    }
    
    func recipeFavorited() {
        self.isRecipeFavorited = true
    }
}
