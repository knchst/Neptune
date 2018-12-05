//
//  RecipesPresenterTests.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import XCTest
import APIKit
import Result
import RealmSwift

@testable import Neptune

class RecipesPresenterTests: XCTestCase {
    let recipesViewMock = RecipesViewMock()
    let recipesServiceMock = RecipesServiceMock()

    override func setUp() {
        
    }

    override func tearDown() {

    }
    
    func testFetchRecipeSuccess() {
        let presenter = RecipesPresenter(view: recipesViewMock)
        recipesServiceMock.result = .success(nil)
        presenter.service = recipesServiceMock
        presenter.fetch()
        
        XCTAssertTrue(recipesViewMock.isFetchStarted)
        XCTAssertTrue(recipesViewMock.isFetchSuccess)
        XCTAssertFalse(recipesViewMock.isFetchFailure)
        XCTAssertTrue(recipesViewMock.isFetchFinished)
    }
    
    func testFetchRecipeFailure() {
        recipesServiceMock.result = .failure(.requestError(RecipesRequestError()))
        let presenter = RecipesPresenter(view: recipesViewMock)
        presenter.service = recipesServiceMock
        presenter.fetch()
        
        XCTAssertTrue(recipesViewMock.isFetchStarted)
        XCTAssertFalse(recipesViewMock.isFetchSuccess)
        XCTAssertTrue(recipesViewMock.isFetchFailure)
        XCTAssertTrue(recipesViewMock.isFetchFinished)
    }
}
