//
//  MockNetworkService.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?

    func fetchData<T>(endPoint: WeatherApp.EndPoint, type: T.Type) async throws -> T? where T : Decodable {
        if let data = mockData {
            let weatherResponse = try JSONDecoder().decode(T.self, from: data)
            return weatherResponse
        }
        return nil
    }
    
    func fetchWeatherIcon(endPoint: WeatherApp.EndPoint) async -> UIImage? {
        return nil
    }
}
