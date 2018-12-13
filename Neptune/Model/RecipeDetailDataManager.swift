//
//  RecipeDetailDataManager.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import RealmSwift
import MediaPlayer

class RecipeDetailDataManager: NSObject {
    private let presenter: RecipeDetailPresenter
    private var currentPlayer: AVPlayer!
    
    init(presenter: RecipeDetailPresenter) {
        self.presenter = presenter
    }
}

// MARK: UITableViewDataSource
extension RecipeDetailDataManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = self.presenter.recipe else { return 0 }
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = self.presenter.recipe else { return 0 }
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return recipe.ingredients.count + 1
        case 3: return recipe.instructions.count + 1
        case 4: return 2
        case 5: return 2
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipe = self.presenter.recipe else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeVideoCellIdetifier, for: indexPath) as! RecipeVideoTableViewCell
            if self.currentPlayer == nil {
                self.currentPlayer = AVPlayer(url: URL(string: recipe.hlsUrl)!)
            }
            cell.player = self.currentPlayer
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeTitleCellIdetifier, for: indexPath) as! RecipeTitleTableViewCell
            cell.titleLabel.attributedText = self.presenter.recipe.attributedTitle
            cell.onFavoriteBtnTapped = { [weak self] in
                self?.presenter.showInDevelopment()
            }
            return cell
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeHeadingCellIdetifier, for: indexPath) as! RecipeHeadingTableViewCell
                cell.headerLabel.text = "材料"
                return cell
            } else {
                let ingredient = recipe.ingredients[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeIngredientCellIdetifier, for: indexPath) as! RecipeIngredientTableViewCell
                cell.nameLabel.text = ingredient.name
                cell.amountLabel.text = ingredient.quantityAmount
                return cell
            }
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeHeadingCellIdetifier, for: indexPath) as! RecipeHeadingTableViewCell
                cell.headerLabel.text = "手順"
                return cell
            } else {
                let instruction = recipe.instructions[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeInstructionCellIdetifier, for: indexPath) as! RecipeInstructionTableViewCell
                cell.orderLabel.text = "\(indexPath.row)."
                cell.bodyLabel.text = instruction.body
                return cell
            }
        case 4:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeHeadingCellIdetifier, for: indexPath) as! RecipeHeadingTableViewCell
                cell.headerLabel.text = "コツ・ポイント"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeMemoCellIdetifier, for: indexPath) as! RecipeMemoTableViewCell
                cell.memoLabel?.text = recipe.memo
                return cell
            }
        case 5:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeHeadingCellIdetifier, for: indexPath) as! RecipeHeadingTableViewCell
                cell.headerLabel.text = "このレシピについて"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: App.Const.RecipeMemoCellIdetifier, for: indexPath) as! RecipeMemoTableViewCell
                cell.memoLabel?.text = recipe.introduction
                return cell
            }
        default:
            fatalError()
        }
    }

}

// MARK: UITableViewDelegate
extension RecipeDetailDataManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? RecipeVideoTableViewCell, let player = self.currentPlayer {
            player.pause()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? RecipeVideoTableViewCell, let player = self.currentPlayer {
            player.play()
        }
    }
}
