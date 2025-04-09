//
//  StubWeatherDashboardCoordinator.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import XCTest
@testable import WeatherApp

final class StubWeatherDashboardCoordinator: WeatherDashboardCoordinatorProtocol {
    var navigateToDetailScreen = 0
    func navigateToDetailScreen(cityWeatherInfoData: WeatherApp.CityWeatherInfo) {
        navigateToDetailScreen += 1
    }
}
