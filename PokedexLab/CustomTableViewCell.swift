//
//  CustomTableViewCell.swift
//  PokedexLab
//
//  Created by Nishita Shetty on 3/7/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var tableImage: UIImageView!

    @IBOutlet weak var tableName: UILabel!
    
    @IBOutlet weak var tableStats: UILabel!
    @IBOutlet weak var tableNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
