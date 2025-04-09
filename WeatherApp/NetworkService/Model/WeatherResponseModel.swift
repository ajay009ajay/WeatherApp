//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation


// MARK: - Welcome
struct WeatherResponseModel: Decodable {
    let coord: Coord?
    let weather: [WeatherModel]?
    let base: String?
    let main: MainWeather?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?

    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base = "base"
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name = "name"
        case cod
    }
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Decodable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Main
struct MainWeather: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct WeatherModel: Decodable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
