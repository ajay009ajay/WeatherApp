//
//  WeatherDashboardView.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 07/04/25.
//

import SwiftUI

struct WeatherDashboardView: View {
    @StateObject var viewModel: WeatherDashboardViewModel

    var body: some View {
        VStack {
            searchBar
            cityInfo
            weatherInfo
            showDetailView
            Spacer()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text(viewModel.configuration.strings.errorAlertTitle),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(NSLocalizedString("ok", comment: "")))
            )
        }
        .onAppear {
            Task {
                await viewModel.fetchStoredCity()
            }
            LocationManagerHelper.shared.monitorLocation()
        }
        .navigationTitle(viewModel.configuration.strings.navigationTitle)
    }

    // Search Bar View
    private var searchBar: some View {
        TextField(viewModel.configuration.strings.searchCityPlaceholder, text: $viewModel.searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onSubmit {
                fetchWeatherData()
            }
            .accessibilityLabel(Text(Weather.Configuration().strings.searchTextAccessibility))
    }

    // City Information View
    private var cityInfo: some View {
        HStack(alignment: .center) {
            Text(viewModel.cityInfo?.cityName ?? "")
                .font(.largeTitle)
            Text(viewModel.cityInfo?.countryCode ?? "")
                .font(.largeTitle)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("\(Weather.Configuration().strings.cityInfoAccessibility) \(viewModel.cityInfo?.cityName ?? "") \(viewModel.cityInfo?.countryCode ?? "")"))

    }

    // Weather Information View
    private var weatherInfo: some View {
        HStack(alignment: .center) {
            if let image = viewModel.icon {
                weatherIcon(image)
                    .accessibilityLabel(Text("Weather icon"))
            }
            Text("\(viewModel.cityInfo?.temperature ?? 0)°C")
            .accessibilityLabel(Text("\(Weather.Configuration().strings.currentTempAccessibility) \(viewModel.cityInfo?.temperature ?? 0)"))
        }
    }

    // Fetch weather data
    private func fetchWeatherData() {
        Task {
            await viewModel.fetchWeatherData(searchCity: viewModel.searchText)
        }
    }

    // Weather Icon View
    private func weatherIcon(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .accessibilityRemoveTraits(.isImage)
    }

    private var showDetailView: some View {
        Button(viewModel.configuration.strings.showDetailBtn) {
            viewModel.showDetailWeatherInfo()
        }
    }
}
