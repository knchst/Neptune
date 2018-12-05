//
//  RecipeDetailViewController.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var id: String!
    private lazy var presenter = RecipeDetailPresenter(view: self, id: self.id)
    private lazy var dataManager = RecipeDetailDataManager(presenter: self.presenter)
    private let loadingView = UIActivityIndicatorView(style: .gray)

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: App.Const.RecipeVideoCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeVideoCellIdetifier)
            tableView.register(UINib(nibName: App.Const.RecipeTitleCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeTitleCellIdetifier)
            tableView.register(UINib(nibName: App.Const.RecipeHeadingCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeHeadingCellIdetifier)
            tableView.register(UINib(nibName: App.Const.RecipeIngredientCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeIngredientCellIdetifier)
            tableView.register(UINib(nibName: App.Const.RecipeInstructionCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeInstructionCellIdetifier)
            tableView.register(UINib(nibName: App.Const.RecipeMemoCellIdetifier, bundle: nil), forCellReuseIdentifier: App.Const.RecipeMemoCellIdetifier)
            tableView.backgroundView = self.loadingView
            tableView.separatorStyle = .none
            tableView.allowsSelection = false
            tableView.tableFooterView = UIView()
            tableView.dataSource = self.dataManager
            tableView.delegate = self.dataManager
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favoriteButtonItem: UIBarButtonItem = {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            btn.imageView?.tintColor = App.Const.brandColor
            btn.setImage(UIImage(imageLiteralResourceName: "heart-outline").withRenderingMode(.alwaysTemplate), for: .normal)
            btn.addTarget(self, action: #selector(self.showInDevelopmentAlert), for: .touchUpInside)
            btn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            return UIBarButtonItem(customView: btn)
        }()
        self.navigationItem.rightBarButtonItem = favoriteButtonItem
        
        fetch()
    }
    
    @objc private func fetch() {
        self.presenter.fetch()
    }
    
    @objc func showInDevelopmentAlert() {
        let alert: UIAlertController = {
            let alert = UIAlertController(title: "すみません", message: "この機能は間に合いませんでした。。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "了解", style: .cancel, handler: nil))
            return alert
        }()
        self.present(alert, animated: true)
    }
}

extension RecipeDetailViewController: RecipeDetailView {
    func fetchStarted() {
        self.loadingView.startAnimating()
    }
    
    func fetchFinished() {
        self.loadingView.stopAnimating()
    }
    
    func fetchSuccess() {
        self.tableView.reloadData()
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
    
    func showInDevelopment() {
        self.showInDevelopmentAlert()
    }
}
