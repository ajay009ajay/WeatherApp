//
//  StubWeatherUseCase.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

final class StubWeatherUseCase: WeatherUseCaseProtocol {
    let response = WeatherResponseModel.mockCityWeather
    let image = UIImage(named: "sun")
    let cityModelResponse = CityModelResponse.cityMock

    func searchBy(cityName: String, countryCode: String, stateCode: String) async throws -> WeatherApp.WeatherResponseModel? {
        return response
    }

    func fetchIcon(iconName: String) async -> UIImage? {
        return image
    }

    func fetchCityNameByLatLong(lat: String, long: String) async throws -> [WeatherApp.CityModelResponse]? {
        return [cityModelResponse]
    }
}
