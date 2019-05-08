//
//  BaseViewController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 07/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

/// Subclass of `UIViewController" with some handy methods.
///
/// - `UIActivityIndicator`.
/// - Generic `UIAlert`.
/// - Table view placeholder.
class BaseViewController: UIViewController {
    /// Show or hide an activity indicatior in the center of the screen.
    ///
    /// - Parameter activityIndicatior: The `UIActivityIndicatorView` you wish to handle.
    func handle(_ activityIndicatior: UIActivityIndicatorView) {
        if activityIndicatior.isAnimating {
            activityIndicatior.stopAnimating()
            activityIndicatior.removeFromSuperview()
        } else {
            activityIndicatior.color = .black
            activityIndicatior.startAnimating()
            activityIndicatior.hidesWhenStopped = true
            view.addSubview(activityIndicatior)
            activityIndicatior.centerInSuperview()
        }
    }

    /// Generic `UIAlertController` with a `.cancel` action.
    ///
    /// The only interaction avaiable to the user will be a `.cancel` action.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - actionTitle: The title for the `.cancel` action.
    func showAlert(title: String?, message: String?, actionTitle: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .cancel))
        present(ac, animated: true)
    }

    /// Add a placeholder view.
    ///
    /// - Parameter text: The message to be displayed.
    /// - Returns: The `UILabel`
    func addPlaceholder(with text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }
}
