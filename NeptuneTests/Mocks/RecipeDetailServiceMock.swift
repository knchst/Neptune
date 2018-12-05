//
//  RecipeDetailServiceMock.swift
//  NeptuneTests
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import Result
@testable import Neptune

class RecipeDetailServiceMock: RecipeDetailService {
    var result: Result<RecipeDetailRequest.Response, SessionTaskError>!
    
    override func fetchRecipe(completion: @escaping (Result<RecipeDetailRequest.Response, SessionTaskError>) -> Void) {
        completion(result)
    }
}
