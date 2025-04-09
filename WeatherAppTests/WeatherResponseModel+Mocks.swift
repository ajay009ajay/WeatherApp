//
//  WeatherResponseModel+Mocks.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

extension WeatherResponseModel {

    static let mockCityWeather = WeatherResponseModel(coord: nil, weather: nil, base: "", main: nil, visibility: 1000, wind: nil, clouds: nil, dt: 10, sys: nil, timezone: 12020, id: 123, name: "Poland", cod: nil)
}
