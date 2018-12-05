//
//  TabBarController.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.delegate = self
    }
}

extension TabBarController {
    func setBadge(index: Int) {
        let item = self.tabBar.items![index]
        guard let itemView = item.value(forKey: "view") as? UIView else { return }
        
        removeBadge(index: index)
        
        let badgeSize: CGFloat = 4.0
        let badge = UIView(
            frame: CGRect(x: (itemView.bounds.width / 2) + 12, y: 6, width: badgeSize, height: badgeSize)
        )
        badge.backgroundColor = App.Const.brandColor
        badge.layer.cornerRadius = badgeSize / 2
        badge.tag = index
        itemView.addSubview(badge)
    }
    
    func removeBadge(index: Int) {
        let item = self.tabBar.items![index]
        guard let itemView = item.value(forKey: "view") as? UIView else { return }
        for subView in itemView.subviews {
            if subView.tag == index {
                subView.removeFromSuperview()
            }
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items!.index(of: item)
        removeBadge(index: index!)
    }
}
