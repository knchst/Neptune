//
//  FavoriteRecipesPresenterTests.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Neptune

class FavoriteRecipesPresenterTests: XCTestCase {
    private let realm = try! Realm()
    private let favoriteViewMock = FavoriteRecipesViewMock()

    override func setUp() {
        
    }

    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testFavoriteRecipesOrderDesc() {
        let presenter = FavoriteRecipesPresenter(view: favoriteViewMock)
        let dataManager = FavoriteRecipesDataManager(presenter: presenter)
        dataManager.setup()
        
        // 3レシピを作成 - 作成日時が1日おき
        let now = Date()
        for i in 1...3 {
            try! realm.write {
                realm.create(
                    Neptune.FavoriteRecipe.self,
                    value: [
                        "id": "\(i)",
                        "title": "タイトル\(i)",
                        "type": "video",
                        "thumbnailSquareUrl": "https://example.com/thumbnail\(i).png",
                        "createdAt": Date(timeInterval: (60 * 60 * 24 * Double(i)), since: now)
                    ]
                )
            }
        }
        
        XCTAssertTrue(["3", "2", "1"] == Array(presenter.recipes.map { $0.id }) as! [String])
    }
}
