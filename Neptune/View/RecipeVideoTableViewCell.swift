//
//  RecipeVideoTableViewCell.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/3/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit
import MediaPlayer

class RecipeVideoTableViewCell: UITableViewCell {
    @IBOutlet weak var playerView: PlayerView!
    
    var player: AVPlayer! {
        didSet {
            self.playerView.player = self.player
            self.player.play()
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [weak self] _ in
                self?.player.seek(to: .zero)
                self?.player.play()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
}
