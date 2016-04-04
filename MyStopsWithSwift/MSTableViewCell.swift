//
//  MSTableViewCell.swift
//  MyStopsWithSwift
//
//  Created by Smbat Tumasyan on 4/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

class MSTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var pinNameLabel: UILabel!

    //------------------------------------------------------------------------------------------
    // MARK: - Class Methods
    //------------------------------------------------------------------------------------------

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var place:Place {
        set(newPlace){
            self.pinNameLabel.text =  newPlace.pinTitle
        }
        get {
            return self.place
        }
    }
}
