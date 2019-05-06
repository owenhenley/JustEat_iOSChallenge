//
//  RestaurantTableViewCell.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

/// Class for the restaurant cells.
class RestaurantTableViewCell: UITableViewCell {

    // Image Cache
    private var imageCache: NSCache = NSCache<NSString, UIImage>()

    // MARK: - Data
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
    @IBOutlet var ratingStars: [UIView]!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
}

// MARK: - Private Methods
private extension RestaurantTableViewCell {
    /// Configure what data to show on screen.
    func configureDetails() {
        // Name
        restaurantNameLabel.text = restauraunt?.name
        setCuisines()
        setLogo()
        setStarRating()
    }

    /// Set the restaurants types of food.
    func setCuisines() {
        guard let cuisineTypes = restauraunt?.cuisineTypes else {
            return
        }
        var cuisineText = ""
        for cuisine in cuisineTypes {
            cuisineText.append(" \(cuisine.name) |")
        }
        cuisineTypesLabel.text = "|\(cuisineText)"
    }

    /// Set the rating for the restaurant.
    func setStarRating() {
        for star in ratingStars {
            guard let rating = restauraunt?.rating else {
                return
            }
            let tag = Double(star.tag)

            if tag <= rating {
                star.backgroundColor = .yellow
            }
        }
    }

    /// Set the restaurants logo.
    func setLogo() {
        // Logo
        if let restaurantLogo = restauraunt?.logo.first {
            if let cachedImage = imageCache.object(forKey: restaurantLogo.logoURLString as NSString) {
                self.logoImageView.image = cachedImage
            } else {
                let networkController = NetworkController.shared
                networkController.fetchLogo(imageURL: restaurantLogo) { (logo) in
                    guard let logo = logo else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.logoImageView.image = logo
                        self.imageCache.setObject(logo, forKey: restaurantLogo.logoURLString as NSString)
                    }
                }
            }
        } else {
            self.logoImageView.image = UIImage(named: "logo")
        }
    }
}

// MARK: - Configure Views
private extension RestaurantTableViewCell {
    /// Setup the view elements.
    func setupViews() {
        configureContainerView()
        logoImageView.layer.cornerRadius = 4
        for r in ratingStars {
            r.layer.cornerRadius = r.frame.height / 2
        }
    }

    /// Configure how the cell container looks.
    func configureContainerView() {
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = .zero
        containerView.layer.cornerRadius = 7.5
    }
}
