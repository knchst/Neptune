//
//  RecipeDetail.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import ObjectMapper

class RecipeDetail: Mappable {
    var id: String!
    var type: String!
    var title: String!
    var thumbnailSquareUrl: String!
    var duration = Int()
    var hlsUrl: String!
    var cookingTime = Int()
    var expense = Int()
    var introduction: String!
    var memo: String!
    var servings: String!
    var ingredients = [RecipeDetail.Ingredient]()
    var instructions = [RecipeDetail.Instruction]()

    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id                 <- map["id"]
        type               <- map["type"]
        title              <- map["attributes.title"]
        thumbnailSquareUrl <- map["attributes.thumbnail-square-url"]
        duration           <- map["attributes.duration"]
        hlsUrl             <- map["attributes.hls-url"]
        cookingTime        <- map["attributes.cooking-time"]
        expense            <- map["attributes.expense"]
        introduction       <- map["attributes.introduction"]
        memo               <- map["attributes.memo"]
        servings           <- map["attributes.servings"]
        ingredients        <- map["attributes.ingredients"]
        instructions       <- map["attributes.instructions"]
    }
    
    // MARK: Ingredient
    class Ingredient: Mappable {
        @objc dynamic var name: String!
        @objc dynamic var actualName: String!
        @objc dynamic var quantityAmount: String!
        
        required convenience init?(map: Map) {
            self.init()
            mapping(map: map)
        }
        
        func mapping(map: Map) {
            name           <- map["name"]
            actualName     <- map["actual-name"]
            quantityAmount <- map["quantity-amount"]
        }
    }
    
    // MARK: Instruction
    class Instruction: Mappable {
        @objc dynamic var sortOrder = Int()
        @objc dynamic var body: String!
        
        required convenience init?(map: Map) {
            self.init()
            mapping(map: map)
        }
        
        func mapping(map: Map) {
            sortOrder <- map["sort-order"]
            body      <- map["body"]
        }
    }
}

extension RecipeDetail {
    var attributedTitle: NSAttributedString {
        get {
            let titleStyle: NSMutableParagraphStyle = {
                let titleStyle = NSMutableParagraphStyle()
                titleStyle.lineHeightMultiple = 1.3
                return titleStyle
            }()
            let attributedText = NSMutableAttributedString(string: self.title)
            attributedText.addAttribute(.paragraphStyle, value: titleStyle, range: NSRange(location: 0, length: attributedText.length))
            return attributedText
        }
    }
}
