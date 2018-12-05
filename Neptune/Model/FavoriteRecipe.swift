//
//  FavoriteRecipe.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import RealmSwift

internal class FavoriteRecipe: Object {
    @objc dynamic var id: String!
    @objc dynamic var type: String!
    @objc dynamic var title: String!
    @objc dynamic var thumbnailSquareUrl: String!
    @objc dynamic var createdAt: Date!
    
    override class func primaryKey() -> String {
        return "id"
    }
}

extension FavoriteRecipe {
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
