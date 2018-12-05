//
//  RecipeDetailPresenterTests.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import XCTest

class RecipeDetailPresenterTests: XCTestCase {
    let recipeDetailViewMock = RecipeDetailViewMock()
    let recipeDetailServiceMock = RecipeDetailServiceMock(id: "")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchRecipeSuccess() {
        let presenter = RecipeDetailPresenter(view: recipeDetailViewMock, id: "")
        recipeDetailServiceMock.result = .success(nil)
        presenter.service = recipeDetailServiceMock
        presenter.fetch()
        
        XCTAssertTrue(recipeDetailViewMock.isFetchStarted)
        XCTAssertTrue(recipeDetailViewMock.isFetchSuccess)
        XCTAssertFalse(recipeDetailViewMock.isFetchFailure)
        XCTAssertTrue(recipeDetailViewMock.isFetchFinished)
    }

    func testFetchRecipeFailure() {
        recipeDetailServiceMock.result = .failure(.requestError(RecipeDetailRequestError()))
        let presenter = RecipeDetailPresenter(view: recipeDetailViewMock, id: "")
        presenter.service = recipeDetailServiceMock
        presenter.fetch()
        
        XCTAssertTrue(recipeDetailViewMock.isFetchStarted)
        XCTAssertFalse(recipeDetailViewMock.isFetchSuccess)
        XCTAssertTrue(recipeDetailViewMock.isFetchFailure)
        XCTAssertTrue(recipeDetailViewMock.isFetchFinished)
    }
}
