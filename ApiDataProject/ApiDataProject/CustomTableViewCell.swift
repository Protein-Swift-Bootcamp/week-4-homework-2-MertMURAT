//
//  CustomTableViewCell.swift
//  ApiDataProject
//
//  Created by Mert Murat on 8.01.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var apiImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
