//
//  RecipesViewController.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import SwiftMessages

final class RecipesViewController: UIViewController {
    private lazy var presenter = RecipesPresenter(view: self)
    private lazy var dataManager = RecipesDataManager(presenter: self.presenter)
    private let loadingView = UIActivityIndicatorView(style: .gray)

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(
                UINib(nibName: App.Const.RecipeCellIdetifier, bundle: nil),
                forCellWithReuseIdentifier: App.Const.RecipeCellIdetifier
            )
            collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
            collectionView.refreshControl = {
                let refreshControl = UIRefreshControl()
                refreshControl.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
                return refreshControl
            }()
            collectionView.dataSource = self.dataManager
            collectionView.delegate = self.dataManager
            collectionView.backgroundView = self.loadingView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
}

extension RecipesViewController {
    @objc private func fetch() {
        presenter.fetch()
    }
}

extension RecipesViewController: RecipesView {
    func fetchStarted() {
        self.loadingView.startAnimating()
    }
    
    func fetchFinished() {
        self.loadingView.stopAnimating()
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    func fetchSuccess() {
        self.collectionView.reloadData()
    }
    
    func fetchFailure(error: String) {
        let alert: UIAlertController = { [weak self] in
            let alert = UIAlertController(title: "エラー", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "リトライ", style: .default, handler: { action in
                self?.fetch()
            }))
            alert.addAction(UIAlertAction(title: "了解", style: .cancel, handler: nil))
            return alert
        }()
        self.present(alert, animated: true)
    }
    
    func showRecipeDetail(id: String) {
        let vc: RecipeDetailViewController = {
            let vc = UIStoryboard(name: "RecipeDetail", bundle: nil).instantiateInitialViewController() as! RecipeDetailViewController
            vc.id = id
            return vc
        }()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func recipeFavorited() {
        if let vc = UIApplication.shared.keyWindow?.rootViewController as? TabBarController {
            vc.setBadge(index: 1)
        }
        
        SwiftMessages.defaultConfig.presentationStyle = .bottom
        SwiftMessages.defaultConfig.duration = .seconds(seconds: 1)
        SwiftMessages.defaultConfig.ignoreDuplicates = true
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .messageView)
            view.configureContent(title: nil, body: "お気に入りに追加しました", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
            view.bodyLabel?.textColor = App.Const.darkColor
            view.backgroundColor = .white
            return view
        }
    }
}
