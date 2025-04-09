//
//  DetailWeatherCoordinator.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import UIKit

class DetailWeatherCoordinator {
    var navigationController: UINavigationController
    private var cityWeather: CityWeatherInfo

    init(navigationController: UINavigationController, cityWeather: CityWeatherInfo) {
        self.navigationController = navigationController
        self.cityWeather = cityWeather
    }
}

extension DetailWeatherCoordinator: Coordinator {
    func build() -> UIViewController? {
        let viewModel = DetailWeatherViewModel(cityWeatherInfo: cityWeather)
        let weatherViewController = HostingController(rootView: DetailWeatherView(viewModel: viewModel))
        return weatherViewController
    }
}
