//
//  NPTAnimation.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class NPTAnimation {
    static func pop(view: UIView, duration: TimeInterval, delay: TimeInterval) {
        view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animateKeyframes(withDuration: duration/3, delay: delay, options: UIView.KeyframeAnimationOptions(), animations: {
            view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: {(finished: Bool) in
            UIView.animateKeyframes(withDuration: duration/3, delay: 0, options: UIView.KeyframeAnimationOptions(), animations: {
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: {(finished: Bool) in
                UIView.animateKeyframes(withDuration: duration/3, delay: 0, options: UIView.KeyframeAnimationOptions(), animations: {
                    view.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: {(finished: Bool) in
                    
                })
            })
        })
    }
}
