//
//  RestaurantTableViewCell.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var cusineTypesLabel: UILabel!
    @IBOutlet var ratingStarImageView: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
