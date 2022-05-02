//
//  LocaitonTableViewCell.swift
//  CoreDataExample
//
//  Created by Ahmet Mucahid Bozkurt on 2.05.2022.
//

import UIKit

class LocaitonTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var lblCityName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(cityName: String) {
        lblCityName.text = cityName
    }

}
