//
//  WeatherDashboardViewModelTests.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

final class WeatherDashboardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFetchWeatherData() async throws {

        let stubUseCase = StubWeatherUseCase()
        let stubCoordinator = StubWeatherDashboardCoordinator()
        let sut = WeatherDashboardViewModel(configuration: Weather.Configuration(), useCase: stubUseCase, coordinator: stubCoordinator)
        await sut.fetchWeatherData(searchCity: "Poland")
        XCTAssertTrue(sut.cityInfo?.cityName == "Poland")
    }

    func testShowDetailWeatherInfo() {
        let stubUseCase = StubWeatherUseCase()
        let stubCoordinator = StubWeatherDashboardCoordinator()
        let sut = WeatherDashboardViewModel(configuration: Weather.Configuration(), useCase: stubUseCase, coordinator: stubCoordinator)
        sut.showDetailWeatherInfo()
        XCTAssertTrue(stubCoordinator.navigateToDetailScreen == 1)
    }
}
