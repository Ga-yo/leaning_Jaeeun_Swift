//
//  TheaterCell.swift
//  MoveMovie
//
//  Created by 이가영 on 2020/04/29.
//  Copyright © 2020 이가영. All rights reserved.
//

import UIKit

class TheaterCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var tel: UILabel!
    @IBOutlet var addr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
