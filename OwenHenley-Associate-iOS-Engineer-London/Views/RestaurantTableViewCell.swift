//
//  RestaurantTableViewCell.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    var restauraunt: Restaurant? {
        didSet {
            configureDetails()
        }
    }

    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var cusineTypesLabel: UILabel!
    @IBOutlet var ratingStarImageView: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureContainerView()
    }

    private func configureDetails() {

    }
}

private extension RestaurantTableViewCell {
    func setupViews() {
        configureContainerView()
    }

    func configureContainerView() {
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = .zero
        containerView.layer.cornerRadius = 7.5
    }

}
