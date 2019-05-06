//
//  NetworkController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 04/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

/// This class handles all the networking to the Just Eat api.
///
/// Call the singleton `shared()` to use this class.
class NetworkController {

    // MARK: - Singleton
    static let shared = NetworkController()

    // MARK: - Properties
    private let baseURL = URL(string: "https://public.je-apis.com/")

    /// Fetch a list of Restauants from a string input.
    ///
    /// Can be used to fetch a list of restaurants from a specific post code.
    /// - Parameters:
    ///   - postcode: A `String` input containing a postcode.
    ///   - completion: A closure passing back the data from the JSON.
    func fetchRestauraunts(postcode: String, completion: @escaping ([Restaurant]?) -> Void) {
        // URL
        guard var url = baseURL else {
            print("Issue with baseURL: \(#function)")
            completion(nil)
            return
        }

        url.appendPathComponent("restaurants")

        // Query
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // #warning("Put postcode back")
        let query = URLQueryItem(name: "q", value: postcode)
        components?.queryItems = [query]

        guard let requestUrl = components?.url else {
            print("Issue with requestURL: \(#function)")
            completion(nil)
            return
        }

        // Header
        let authCode = "Basic VGVjaFRlc3Q6bkQ2NGxXVnZreDVw"
        let host = "public.je-apis.com"
        let headers = [
            "accept-tenant": "uk",
            "accept-language": "en-GB",
            "authorization": authCode,
            "host": host
        ]

        // Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.httpBody = nil

        // Network Call
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error -> Void in
            if let error = error {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary.restaurants)
            } catch {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }

    /// Fetch a restaurants logo.
    ///
    /// - Parameters:
    ///   - imageURL: The string url where the image is stored.
    ///   - completion: A closure passing back the image data.
    func fetchLogo(imageURL: Logo?, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = imageURL?.logoURLString else {
            completion(nil)
            return
        }

        guard let logoURL = URL(string: imageURL) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: logoURL)
        request.httpMethod = "GET"
        request.httpBody = nil

        // Network Call
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            completion(UIImage(data: data))
        }
        dataTask.resume()
    }
}
