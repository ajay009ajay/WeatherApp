//
//  WeatherClientTests.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

final class WeatherClientTests: XCTestCase {

    func testSearchBy() async throws {
        let expectedData = Data("""
            {"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":288.37,"feels_like":287.12,"temp_min":287.01,"temp_max":289.36,"pressure":1027,"humidity":45,"sea_level":1027,"grnd_level":1022},"visibility":10000,"wind":{"speed":3.6,"deg":80},"clouds":{"all":49},"dt":1744113979,"sys":{"type":2,"id":268730,"country":"GB","sunrise":1744089583,"sunset":1744137871},"timezone":3600,"id":2643743,"name":"Poland","cod":200
            }
            """.utf8)
        let mockNetworkService = MockNetworkService()
        mockNetworkService.mockData = expectedData
        let client = WeatherClient(networkService: mockNetworkService)
        let value = try? await client.searchBy(cityName: "Poland")
        XCTAssertEqual(value?.name, "Poland")
        XCTAssertEqual(value?.cod, 200)
        XCTAssertEqual(value?.timezone, 3600)
        XCTAssertEqual(value?.id, 2643743)
        XCTAssertEqual(value?.visibility, 10000)
    }

    func testFetchCityNameByLatLong() async throws {
        let expectedData = Data("""
            [
            {"name":"SanFrancisco","local_names":{},"lat":37.7790262,"lon":-122.419906,"country":"US","state":"California"}
            ]
            """.utf8)
        let mockNetworkService = MockNetworkService()
        mockNetworkService.mockData = expectedData
        let client = WeatherClient(networkService: mockNetworkService)
        let value = try? await client.fetchCityNameByLatLong(lat: "12", long: "15")
        XCTAssertEqual(value?.first?.cityName, "SanFrancisco")
        XCTAssertEqual(value?.first?.countryCode, "US")
        XCTAssertEqual(value?.first?.state, "California")
    }
}
