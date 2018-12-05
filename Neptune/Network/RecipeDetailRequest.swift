//
//  RecipeDetailRequest.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper
import SwiftyJSON
@testable import Neptune

class RecipeDetailRequestError: Error { }

protocol RecipeDetailRequestType: Request { }

struct RecipeDetailRequest: RecipeDetailRequestType {
    typealias Response = RecipeDetail?
    
    var baseURL: URL { return URL(string: App.Const.API_V1_VIDEOS_PATH + self.id)! }
    var method: HTTPMethod { return .get }
    var path: String { return "" }
    
    var id: String!
    
    init(id: String) {
        self.id = id
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        if let json = JSON(rawValue: object), let recipeDetail = Mapper<RecipeDetail>().map(JSONObject: json["data"].object) {
            return recipeDetail
        }
        return nil
    }
}
