//
//  RestaurantTableViewCell.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    let networkController = NetworkController.shared

    var restauraunt: Restaurant? {
        didSet {
            configureDetails()
        }
    }

    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var cuisineTypesLabel: UILabel!
    @IBOutlet var ratingStarImageView: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureContainerView()
    }
}

// MARK: - Private Methods
private extension RestaurantTableViewCell {
    /// <#Description#>
    private func configureDetails() {
        guard let cuisineTypes = restauraunt?.cuisineTypes else {
            return
        }

        var cuisineText = ""
        for cuisine in cuisineTypes {
            cuisineText.append(" \(cuisine.name) |")
        }

        cuisineTypesLabel.text = "|\(cuisineText)"
        restaurantNameLabel.text = restauraunt?.name

        if let restaurantLogo = restauraunt?.logo.first {
            networkController.fetchLogo(imageURL: restaurantLogo) { (logo) in
                guard let logo = logo else {
                    return
                }
                DispatchQueue.main.async {
                    self.logoImageView.image = logo
                }
            }
        } else {
            // default
        }
    }

    func setupViews() {
        configureContainerView()
        logoImageView.layer.cornerRadius = 4
    }

    func configureContainerView() {
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = .zero
        containerView.layer.cornerRadius = 7.5
    }
}
