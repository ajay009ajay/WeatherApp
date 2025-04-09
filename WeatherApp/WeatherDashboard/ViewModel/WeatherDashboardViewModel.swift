//
//  WeatherDashboardViewModel.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 07/04/25.
//

import Foundation
import UIKit
import Combine

class WeatherDashboardViewModel: ObservableObject {

    @Published private(set) var cityInfo: CityWeatherInfo?
    @Published private(set) var icon: UIImage?
    @Published var showError = false
    @Published private(set) var errorMessage: String = ""
    @Published var searchText: String = ""

    private(set) var configuration: Weather.Configuration
    private var useCase: WeatherUseCaseProtocol
    private(set) var coordinator: WeatherDashboardCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
        configuration: Weather.Configuration,
        useCase: WeatherUseCaseProtocol,
        coordinator: WeatherDashboardCoordinatorProtocol
    ) {
        self.configuration = configuration
        self.useCase = useCase
        self.coordinator = coordinator

        LocationManagerHelper.shared.$userLocation
            .sink { finished in
                print("Finished")
            } receiveValue: {[weak self]  location in
                guard let self = self else { return }
                let latitude = String(location?.coordinate.latitude ?? 0)
                let longitude = String(location?.coordinate.longitude ?? 0)
                Task {
                    await self.fetchWeatherByCoordinates(lat: latitude, long: longitude)
                }
            }.store(in: &cancellables)
    }

    // MARK: - Fetch Weather Data

    @MainActor
    private func fetchWeatherByCoordinates(lat: String, long: String) {
        Task {
            do {
                let cityNameResponse = try await useCase.fetchCityNameByLatLong(lat: lat, long: long)?.first
                guard let cityName = cityNameResponse?.cityName else { return }
                let cityInfoObj = CityWeatherInfo(cityName: cityName)
                let response = try await fetchWeather(cityInfo: cityInfoObj)
                updateWeatherData(response: response)
            } catch {
                updateErrorAlert(error: error)
            }
        }
    }

    @MainActor
    func fetchStoredCity() async {
        if let response = FileSystemManager.readFromFile() {
            updateWeatherData(response: response)
        }
    }

    @MainActor
    func fetchWeatherData(searchCity: String) async {
        guard Reachability.isConnectedToNetwork() else {
            self.errorMessage = WeatherError.noInternetConnection.errorDescription ?? ""
            self.showError = true
            return
        }

        guard !searchCity.isEmpty else { return }

        do {
            let cityInfoObj = CityWeatherInfo(cityName: searchCity)
            let response = try await fetchWeather(cityInfo: cityInfoObj)
            updateWeatherData(response: response)
        } catch {
            updateErrorAlert(error: error)
        }
    }

    /*
     Api call to get weather data
     */
    private func fetchWeather(cityInfo: CityWeatherInfo?) async throws -> WeatherResponseModel? {
        let response = try await useCase.searchBy(
            cityName: cityInfo?.cityName ?? "",
            countryCode: cityInfo?.countryCode ?? "",
            stateCode: cityInfo?.stateCode ?? ""
        )
        return response
    }

    /*
     Update UI
     */
    @MainActor
    private func updateWeatherData(response: WeatherResponseModel?) {
        guard let response = response else { return }
        self.cityInfo = CityWeatherInfo(response: response)
        if let icon = response.weather?.first?.icon {
            updateWeatherIcon(icon: icon)
        }
    }

    @MainActor
    private func updateWeatherIcon(icon: String) {
        Task {
            self.icon = await useCase.fetchIcon(iconName: icon)
        }
    }

    /*
     Navigate to detail screen
     */
    func showDetailWeatherInfo() {
        coordinator.navigateToDetailScreen(
            cityWeatherInfoData: cityInfo ?? CityWeatherInfo(
                cityName: searchText
            )
        )
    }

    // MARK: - Error Handling
    private func updateErrorAlert(error: Error?) {
        if let errorMessage = (error as? WeatherError)?.errorDescription {
            self.errorMessage = errorMessage
            self.showError = true
        }
    }
}
