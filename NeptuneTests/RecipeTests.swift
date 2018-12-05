//
//  RecipeTests.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Neptune

class RecipeTests: XCTestCase {
    let realm = try! Realm()

    private let recipeData = [
        "id": "abcd-efgh-ijkl",
        "title": "タイトル",
        "type": "video",
        "thumbnailSquareUrl": "https://example.com/thumbnail.png"
    ]

    override func setUp() {
        
    }

    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testIsFavoritedPropertyReturnTrue() {
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        realm.create(Neptune.FavoriteRecipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertTrue(recipe.isFavorited)
    }
    
    func testIsFavoritedPropertyReturnFalse() {
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertFalse(recipe.isFavorited)
    }
    
    func testToggleFavoriteAddRecipe() {
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertTrue(recipe.toggleFavorite())
    }
    
    func testToggleFavoriteRemoveRecipe() {
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        realm.create(Neptune.FavoriteRecipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertFalse(recipe.toggleFavorite())
    }
}
