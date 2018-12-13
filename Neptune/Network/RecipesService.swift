//
//  RecipesService.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import Result

protocol RecipesServiceable {
    func fetchRecipes(completion: @escaping (Result<RecipesRequest.Response, SessionTaskError>) -> Void)
}

class RecipesService: RecipesServiceable {
    func fetchRecipes(completion: @escaping (Result<RecipesRequest.Response, SessionTaskError>) -> Void) {
        let request = RecipesRequest()
        Session.send(request) { result in
            switch result {
            case .success(let json):
                print("[RecipesRequest] Success: \(json)")
            case .failure(let error):
                print("[RecipesRequest] Failure: \(error)")
            }
            completion(result)
        }
    }
}
