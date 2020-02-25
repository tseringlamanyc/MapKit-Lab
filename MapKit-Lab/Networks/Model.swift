//
//  Model.swift
//  MapKit-Lab
//
//  Created by Tsering Lama on 2/24/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct SchoolData: Codable {
    let school_name: String
    let latitude: Double
    let longitude: Double
    let location: String
}
