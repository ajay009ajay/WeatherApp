//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import UIKit

protocol WeatherUseCaseProtocol {
    func searchBy(
        cityName: String,
        countryCode: String,
        stateCode: String
    ) async throws -> WeatherResponseModel?

    func fetchIcon(iconName: String) async -> UIImage?
    func fetchCityNameByLatLong(lat: String, long: String) async throws -> [CityModelResponse]?
}

final class WeatherUseCase: WeatherUseCaseProtocol {

    private var client: WeatherClientProtocol

    init(client: WeatherClientProtocol) {
        self.client = client
    }

    func searchBy(
        cityName: String,
        countryCode: String = "",
        stateCode: String = ""
    ) async throws -> WeatherResponseModel? {
        return try await client.searchBy(
            cityName: cityName,
            countryCode: countryCode,
            stateCode: stateCode
        )
    }

    func fetchIcon(iconName: String) async -> UIImage? {
        return await client.fetchIcon(iconName: iconName)
    }

    func fetchCityNameByLatLong(lat: String, long: String) async throws -> [CityModelResponse]? {
        return try await client.fetchCityNameByLatLong(lat: lat, long: long)
    }
}
