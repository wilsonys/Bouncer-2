//
//  Restaurant.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import Foundation

struct Restaurant: Codable {
    var location_id: String
    var brand_name: String
    var cuisine_type: String
    var price_scale: Int
    var latitude: Double
    var longitude: Double
}

struct RestaurantCount: Codable {
    var restaurant: Restaurant
    var currentUserAttending: Bool
    var attendeeCount: Int
}
