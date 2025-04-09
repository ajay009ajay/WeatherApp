//
//  WeatherUseCaseTests.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

final class WeatherUseCaseTests: XCTestCase {

    func testSearchBy() async {
        let expectedResult = WeatherResponseModel.mockCityWeather
        let sut = WeatherUseCase(client: StubWeatherClient())
        let response = try? await sut.searchBy(cityName: "Poland")
        XCTAssertTrue(response?.name == expectedResult.name)
        XCTAssertTrue(response?.timezone == expectedResult.timezone)
        XCTAssertTrue(response?.visibility == expectedResult.visibility)
    }

    func testFetchIcon() async {
        let expectedResult = UIImage(named: "sun")
        let sut = WeatherUseCase(client: StubWeatherClient())
        let response = await sut.fetchIcon(iconName: "sun")
        XCTAssertTrue(response == expectedResult)
    }

    func testFetchCityNameByLatLong()  async {
        let expectedResult = [CityModelResponse.cityMock]
        let sut = WeatherUseCase(client: StubWeatherClient())
        let response = try? await sut.fetchCityNameByLatLong(lat: "11", long: "12")
        XCTAssertTrue(response?.count == 1)
        XCTAssertEqual(response?.first?.cityName, expectedResult.first?.cityName)
    }
}
