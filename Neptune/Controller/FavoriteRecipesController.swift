//
//  FavoriteRecipesViewController.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class FavoriteRecipesViewController: UIViewController {
    private lazy var presenter = FavoriteRecipesPresenter(view: self)
    private lazy var dataManager = FavoriteRecipesDataManager(presenter: self.presenter)

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(
                UINib(nibName: App.Const.RecipeCellIdetifier, bundle: nil),
                forCellWithReuseIdentifier: App.Const.RecipeCellIdetifier
            )
            collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
            collectionView.dataSource = self.dataManager
            collectionView.delegate = self.dataManager
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        self.dataManager.setup()
        self.collectionView.reloadData()
    }
}

extension FavoriteRecipesViewController: FavoriteRecipesView {
    func update(deletions: [Int], insertions: [Int]) {
        self.collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.deleteItems(at: deletions.map { IndexPath(row: $0, section: 0) })
            self?.collectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) })
        })
    }
    
    func showRecipeDetail(id: String) {
        let vc: RecipeDetailViewController = {
            let vc = UIStoryboard(name: "RecipeDetail", bundle: nil).instantiateInitialViewController() as! RecipeDetailViewController
            vc.id = id
            return vc
        }()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
