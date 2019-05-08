//
//  RestaurantTableViewCell.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
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
    @IBOutlet var openClosedView: UIView!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var openClosedLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
}

// MARK: - Set cell details.
private extension RestaurantTableViewCell {
    /// Configure what data to show on screen.
    func configureDetails() {
        setName()
        setIsOpen()
        setCuisines()
        setLogo()
        setRating()
    }

    /// Set the restaurant name.
    func setName() {
        guard let name = restauraunt?.name else {
            return
        }
        restaurantNameLabel.text = name
    }


    /// Check if the restaurant is open.
    func setIsOpen() {
        guard let isOpenNow = restauraunt?.isOpenNow else {
            return
        }

        if isOpenNow {
            openClosedLabel.text = "Open"
            openClosedView.backgroundColor = .green
        } else {
            openClosedLabel.text = "Closed"
            openClosedView.backgroundColor = .red
        }
    }

    /// Set the restaurants types of food.
    func setCuisines() {
        guard let cuisineTypes = restauraunt?.cuisineTypes else {
            return
        }
        var cuisineText = ""
        for cuisine in cuisineTypes {
            guard let name = cuisine.name else {
                return
            }
            cuisineText.append(" \(name) |")
        }
        cuisineTypesLabel.text = "|\(cuisineText)"
    }

    /// Set the rating for the restaurant.
    func setRating() {
        guard let rating = restauraunt?.rating else {
            return
        }
        ratingLabel.text = "\(rating)/6.0"

        // I feel like this could be handled much better...
        if rating <= 2 {
            ratingView.backgroundColor = .red
            return
        }

        if rating <= 3.5 {
            ratingView.backgroundColor = .orange
            return
        }

        if rating > 3.5 {
            ratingView.backgroundColor = .green
        }
    }

    /// Set the restaurants logo.
    func setLogo() {
        // Logo
        guard let logo = restauraunt?.logo else {
            return
        }

        if let restaurantLogo = logo.first {
            if let cachedImage = imageCache.object(forKey: restaurantLogo.logoURLString! as NSString) {
                self.logoImageView.image = cachedImage
            } else {
                let networkController = NetworkController.shared
                networkController.fetchLogo(imageURL: restaurantLogo) { (logo) in
                    guard let logo = logo else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.logoImageView.image = logo
                        self.imageCache.setObject(logo, forKey: restaurantLogo.logoURLString! as NSString)
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
        let cornerRadius = openClosedView.frame.height / 2
        openClosedView.layer.cornerRadius = cornerRadius
        ratingView.layer.cornerRadius = cornerRadius
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
