//
//  CityModelResponse.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//


struct CityModelResponse: Decodable {
    let cityName: String?
    let countryCode: String?
    let state: String?

    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case countryCode = "country"
        case state = "state"
    }
}
