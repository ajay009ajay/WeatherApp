//
//  DetailWeatherView.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import SwiftUI

struct DetailWeatherView: View {
    @StateObject var viewModel: DetailWeatherViewModel
    private let constant = DetailWeather.Configuration().strings
    var body: some View {
        VStack(alignment: .center) {
            Text(String(format: constant.detailTemperature, String(viewModel.cityWeatherInfo.temperature ?? 0)))
                .font(.title)
                .bold()
            Text(String(format: constant.humidity, String(viewModel.cityWeatherInfo.humidity ?? 0)))
            Text(String(format: constant.minimumTemp, String(viewModel.cityWeatherInfo.minimumTemp ?? 0)))
            Text(String(format: constant.visibility, String(viewModel.cityWeatherInfo.visibility ?? 0)))
            Spacer()
        }
        .navigationTitle(viewModel.cityWeatherInfo.cityName ?? "")
    }
}
