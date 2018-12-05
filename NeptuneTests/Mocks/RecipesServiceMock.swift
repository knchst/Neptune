//
//  RecipesServiceMock.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

@testable import Neptune
import Foundation
import APIKit
import Result

class RecipesServiceMock: RecipesServiceable {
    var result: Result<RecipesRequest.Response, SessionTaskError>!
    
    func fetchRecipes(completion: @escaping (Result<RecipesRequest.Response, SessionTaskError>) -> Void) {
        completion(result)
    }
}
