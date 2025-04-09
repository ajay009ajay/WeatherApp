//
//  WeatherDashboardCoordinator.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 07/04/25.
//

import UIKit

protocol WeatherDashboardCoordinatorProtocol {
    func navigateToDetailScreen(cityWeatherInfoData: CityWeatherInfo)
}
class WeatherDashboardCoordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension WeatherDashboardCoordinator: Coordinator {
    func build() -> UIViewController? {
        let networkService = NetworkService(session: URLSession.shared)
        let client = WeatherClient(networkService: networkService)
        let useCase = WeatherUseCase(client: client)
        let viewModel = WeatherDashboardViewModel(
            configuration: Weather.Configuration(),
            useCase: useCase,
            coordinator: self
        )
        let weatherViewController = HostingController(rootView: WeatherDashboardView(viewModel: viewModel))
        // Set the root view controller
        navigationController?.viewControllers = [weatherViewController]
        return nil
    }
}

extension WeatherDashboardCoordinator: WeatherDashboardCoordinatorProtocol {
    func navigateToDetailScreen(cityWeatherInfoData: CityWeatherInfo) {
        guard let navigationController else { return }
        let detailCoordinator = DetailWeatherCoordinator(navigationController: navigationController, cityWeather: cityWeatherInfoData)
        let viewController = detailCoordinator.build() ?? UIViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
