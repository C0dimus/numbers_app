//
//  NAModelCell.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import UIKit
import SDWebImage

class NAModelCell: UITableViewCell {
    static let nibName = "NAModelCell"
    static let cellId = "NAModelCellId"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if isSelected {
            return
        }
        if highlighted {
            self.backgroundColor = UIColor.lavaRed
            self.nameLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            self.nameLabel.textColor = .black
        }
    }
    
    func fillWith(model: NAModel, isSelected: Bool) {
        self.isSelected = isSelected
        if self.isSelected {
            backgroundColor = UIColor.niceBlue
            nameLabel.textColor = .white
        } else {
            backgroundColor = .white
            nameLabel.textColor = .black
        }
        nameLabel.text = model.name
        cellImageView.sd_setImage(with: URL(string: model.image), completed: nil)
    }
    
}
