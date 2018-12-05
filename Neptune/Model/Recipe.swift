//
//  Recipe.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

internal class Recipe: Object {
    @objc dynamic var id: String!
    @objc dynamic var type: String!
    @objc dynamic var title: String!
    @objc dynamic var thumbnailSquareUrl: String!
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
}

// MARK: Mappable
extension Recipe: Mappable {
    func mapping(map: Map) {
        id                 <- map["id"]
        type               <- map["type"]
        title              <- map["attributes.title"]
        thumbnailSquareUrl <- map["attributes.thumbnail-square-url"]
    }
}

extension Recipe {
    var isFavorited: Bool {
        get {
            guard let _ = realm?.object(ofType: FavoriteRecipe.self, forPrimaryKey: self.id) else { return false }
            return true
        }
    }
    
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
    
    func toggleFavorite() -> Bool {
        if let favoriteRecipe = realm?.object(ofType: FavoriteRecipe.self, forPrimaryKey: self.id) {
            try! realm?.write {
                realm?.delete(favoriteRecipe)
            }
            return false
        } else {
            try! realm?.write {
                realm?.create(FavoriteRecipe.self, value: [
                    "id": self.id,
                    "title": self.title,
                    "type": self.type,
                    "thumbnailSquareUrl": self.thumbnailSquareUrl,
                    "createdAt": Date()
                ])
            }
            return true
        }
    }
}
