//
//  FavoriteRecipesDataManagerTests.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Neptune

class FavoriteRecipesDataManagerTests: XCTestCase {
    private let realm = try! Realm()
    private let favoriteViewMock = FavoriteRecipesViewMock()
    private let recipeData: [String : Any] = [
        "id": "abcd-efgh-ijkl",
        "title": "タイトル",
        "type": "video",
        "thumbnailSquareUrl": "https://example.com/thumbnail.png",
        "createdAt": Date()
    ]
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testSetupMethodShouldSetNotificationToken() {
        let presenter = FavoriteRecipesPresenter(view: favoriteViewMock)
        let dataManager = FavoriteRecipesDataManager(presenter: presenter)
        XCTAssertNil(dataManager.favoriteRecipesNotificationToken)
        dataManager.setup()
        XCTAssertNotNil(dataManager.favoriteRecipesNotificationToken)
    }
    
    func testFavoriteRecipesNotificationShouldBeCalledWhenFavoriteRecipeWasAdded() {
        let presenter = FavoriteRecipesPresenter(view: favoriteViewMock)
        let dataManager = FavoriteRecipesDataManager(presenter: presenter)
        let exp = expectation(description: "insertions")
        dataManager.favoriteRecipesNotificationToken = presenter.recipes.observe { changes in
            switch changes {
            case .initial: break
            case .update(_, let deletions, let insertions, _):
                presenter.update(deletions: deletions, insertions: insertions)
                if insertions.count > 0 {
                    exp.fulfill()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertTrue(recipe.toggleFavorite())
        waitForExpectations(timeout: 5, handler: { [weak self] error in
            guard let favoriteViewMock = self?.favoriteViewMock else { fatalError() }
            XCTAssertTrue(favoriteViewMock.isUpdated)
            XCTAssertTrue(favoriteViewMock.hasInsertions)
        })
    }
    
    func testFavoriteRecipesNotificationShouldBeCalledWhenFavoriteRecipeWasRemoved() {
        let presenter = FavoriteRecipesPresenter(view: favoriteViewMock)
        let dataManager = FavoriteRecipesDataManager(presenter: presenter)
        let exp = expectation(description: "deletions")
        dataManager.favoriteRecipesNotificationToken = presenter.recipes.observe { changes in
            switch changes {
            case .initial: break
            case .update(_, let deletions, let insertions, _):
                presenter.update(deletions: deletions, insertions: insertions)
                if deletions.count > 0 {
                    exp.fulfill()
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
        realm.beginWrite()
        let recipe = realm.create(Neptune.Recipe.self, value: recipeData)
        realm.create(Neptune.FavoriteRecipe.self, value: recipeData)
        try! realm.commitWrite()
        XCTAssertFalse(recipe.toggleFavorite())
        waitForExpectations(timeout: 5, handler: { [weak self] error in
            guard let favoriteViewMock = self?.favoriteViewMock else { fatalError() }
            XCTAssertTrue(favoriteViewMock.isUpdated)
            XCTAssertTrue(favoriteViewMock.hasDeletions)
        })
    }
}
