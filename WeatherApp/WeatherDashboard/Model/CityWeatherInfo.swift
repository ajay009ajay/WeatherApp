//
//  CityWeatherInfo.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation

struct CityWeatherInfo {
    let cityName: String?
    let countryCode: String?
    let stateCode: String?
    let temperature: Int?
    let humidity: Int?
    let visibility: Int?
    let minimumTemp: Int?

    init(
        cityName: String?,
        countryCode: String? = nil,
        stateCode: String? = nil,
        temperature: Int? = nil,
        humidity: Int? = nil,
        visibility: Int? = nil,
        minimumTemp: Int? = nil
    ) {
        self.cityName = cityName
        self.countryCode = countryCode
        self.stateCode = stateCode
        self.temperature = temperature
        self.humidity = humidity
        self.visibility = visibility
        self.minimumTemp = minimumTemp
    }

    init(response: WeatherResponseModel) {
        self.cityName = response.name
        self.countryCode = response.sys?.country
        let celsiusTemp = Int(round((response.main?.temp ?? 0) - 273))
        self.temperature = celsiusTemp
        self.stateCode = ""
        self.humidity = response.main?.humidity
        self.visibility = response.visibility
        let celsiusMinTemp = Int(round((response.main?.tempMin ?? 0) - 273))
        self.minimumTemp = celsiusMinTemp
    }
}
