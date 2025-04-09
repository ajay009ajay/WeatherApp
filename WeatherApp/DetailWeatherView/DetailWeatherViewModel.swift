//
//  DetailWeatherViewModel.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation

class DetailWeatherViewModel: ObservableObject {
    @Published private(set) var cityWeatherInfo: CityWeatherInfo

    init(cityWeatherInfo: CityWeatherInfo) {
        self.cityWeatherInfo = cityWeatherInfo
    }
}
