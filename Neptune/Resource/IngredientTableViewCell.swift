//
//  IngredientTableViewCell.swift
//  Neptune
//
//  Created by Kenichi Saito on 12/5/18.
//  Copyright © 2018 Kenichi Saito. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
