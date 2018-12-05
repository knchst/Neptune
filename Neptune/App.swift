//
//  App.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import Foundation
import UIKit

struct App {
    struct Const {
        static let brandColor = UIColor(red: 0.86, green: 0.70, blue: 0.30, alpha: 1.0)
        static let darkColor = UIColor(red: 0.39, green: 0.37, blue: 0.35, alpha: 1.0)
        static let lightGlayColor = UIColor(red: 0.96, green: 0.95, blue: 0.94, alpha: 1.0)
        
        static let API_V1_BASE_URL = "https://contents.kurashiru.com/api/v1/"
        static let API_V1_VIDEOS_PATH = API_V1_BASE_URL + "videos/"
        static let SAMPLE_JSON_URL = "https://s3-ap-northeast-1.amazonaws.com/data.kurashiru.com/videos_sample.json"
        
        static let RecipeCellIdetifier = "RecipeCollectionViewCell"
        static let RecipeVideoCellIdetifier = "RecipeVideoTableViewCell"
        static let RecipeTitleCellIdetifier = "RecipeTitleTableViewCell"
        static let RecipeHeadingCellIdetifier = "RecipeHeadingTableViewCell"
        static let RecipeIngredientCellIdetifier = "RecipeIngredientTableViewCell"
        static let RecipeInstructionCellIdetifier = "RecipeInstructionTableViewCell"
        static let RecipeMemoCellIdetifier = "RecipeMemoTableViewCell"
    }
}
