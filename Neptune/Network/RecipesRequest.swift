//
//  RecipesRequest.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper
import SwiftyJSON
import RealmSwift

class RecipesRequestError: Error { }

protocol RecipesRequestType: Request { }

struct RecipesRequest: RecipesRequestType {
    typealias Response = JSON?
    
    var baseURL: URL { return URL(string: App.Const.SAMPLE_JSON_URL)! }
    var method: HTTPMethod { return .get }
    var path: String { return "" }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        if let json = JSON(rawValue: object),
            let recipes = json["data"].arrayObject,
            let mappedRecipes = Mapper<Recipe>().mapArray(JSONObject: recipes) {
            let realm = try? Realm()
            try realm?.write {
                realm?.add(mappedRecipes, update: true)
            }
            return json
        }
        return nil
    }
}

