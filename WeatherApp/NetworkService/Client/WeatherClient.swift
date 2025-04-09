//
//  WeatherClient.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import UIKit

protocol WeatherClientProtocol {
    func searchBy(
        cityName: String,
        countryCode: String,
        stateCode: String
    ) async throws -> WeatherResponseModel?

    func fetchIcon(iconName: String) async -> UIImage?

    func fetchCityNameByLatLong(lat: String, long: String) async throws -> [CityModelResponse]?
}

final class WeatherClient {
    private var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension WeatherClient: WeatherClientProtocol {

    func searchBy(
        cityName: String,
        countryCode: String = "",
        stateCode: String = ""
    ) async throws -> WeatherResponseModel? {
        return try await networkService.fetchData(endPoint: .weather(cityName, countryCode, stateCode), type: WeatherResponseModel.self)
    }

    func fetchIcon(iconName: String) async -> UIImage? {
        return await networkService.fetchWeatherIcon(endPoint: .icon(iconName))
    }

    func fetchCityNameByLatLong(lat: String, long: String) async throws -> [CityModelResponse]? {
        return try await networkService.fetchData(endPoint: .latLong(lat, long), type: [CityModelResponse].self)
    }
}
