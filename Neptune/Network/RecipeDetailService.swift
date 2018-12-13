//
//  RecipeDetailService.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import Result
import RealmSwift

protocol RecipeDetailServiceable {
    func fetchRecipe(completion: @escaping (Result<RecipeDetailRequest.Response, SessionTaskError>) -> Void)
}

class RecipeDetailService: RecipeDetailServiceable {
    var id: String!
    
    init(id: String) {
        self.id = id
    }
    
    func fetchRecipe(completion: @escaping (Result<RecipeDetailRequest.Response, SessionTaskError>) -> Void) {
        let request = RecipeDetailRequest(id: self.id)
        Session.send(request) { result in
            switch result {
            case .success(let recipe):
                print("[RecipeDetailRequest] Success: \(recipe?.toJSON())")
            case .failure(let error):
                print("[RecipeDetailRequest] Failure: \(error)")
            }
            completion(result)
        }
    }
}
