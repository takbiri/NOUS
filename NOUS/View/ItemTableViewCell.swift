//
//  ItemTableViewCell.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/16/22.
//

import UIKit
import SDWebImage

class ItemTableViewCell: ThemedCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(item: Item) {
        guard let url = URL(string: item.imageUrl) else {return}
        self.previewImageView.sd_setImage(with: url)
        
        self.nameLabel.text = item.title
        self.descriptionLabel.text = item.description
    }
}
