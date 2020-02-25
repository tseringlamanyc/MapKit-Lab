//
//  APIClient.swift
//  MapKit-Lab
//
//  Created by Tsering Lama on 2/24/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import NetworkHelper

struct SchoolAPI {
    static func getSchools(completion: @escaping (Result<[SchoolData], AppError>) -> ()) {
        let endpointURL = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let allSchools = try JSONDecoder().decode([SchoolData].self, from: data)
                    completion(.success(allSchools))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
