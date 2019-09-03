//
//  DisplayCell.swift
//  Demo
//
//  Created by Manek Bindi on 03/09/19.
//  Copyright © 2019 Bindi Manek. All rights reserved.
//

import UIKit

class DisplayCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    @IBOutlet weak var swtToggle: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
