//
//  NetworkController.swift
//  OwenHenley-Associate-iOS-Engineer-London
//
//  Created by Owen Henley on 06/05/2019.
//  Copyright © 2019 Owen Henley. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case badData
    case failedToParseData
    case systemError
}

/// This class handles all the networking to the Just Eat API.
///
/// NB: Call the singleton `shared()` to use this class.
class NetworkController {

    // MARK: - Properties
    private lazy var baseURL = URL(string: value(for: "base-url"))

    /// Fetch a list of Restauants from a string input.
    ///
    /// Can be used to fetch a list of restaurants from a specific post code.
    /// - Parameters:
    ///   - postcode: A `String` input containing a postcode.
    ///   - completion: A closure passing back the data from the JSON.
    func fetchRestauraunts(postcode: String, completion: @escaping (Result<[Restaurant], NetworkError>) -> Void) {
        // URL
        guard var url = baseURL else {
            print("Issue with baseURL: \(#function)")
            return
        }

        url.appendPathComponent("restaurants")

        // Query
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let query = URLQueryItem(name: "q", value: postcode)
        components?.queryItems = [query]

        guard let requestUrl = components?.url else {
            print("Issue with requestURL: \(#function)")
            return
        }

        // Header
        let headers = ["accept-tenant": value(for: "accept-tenant"),
                     "accept-language": value(for: "accept-language"),
                       "authorization": value(for: "authorization"),
                                "host": value(for: "host")]

        // Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.httpBody = nil

        // Network Call
        URLSession.shared.dataTask(with: request) { data, _, error -> Void in
            if let error = error {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(.failure(.systemError))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }

            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let restaurants = topLevelDictionary.restaurants
                completion(.success(restaurants))
            } catch {
                print("Error: \(#file), \(#function), \(#line), Message: \(error). \(error.localizedDescription)")
                completion(.failure(.failedToParseData))
                return
            }
        }.resume()
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

        // URL
        guard let logoURL = URL(string: imageURL) else {
            completion(nil)
            return
        }

        // Request
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
