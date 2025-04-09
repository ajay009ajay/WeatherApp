//
//  Weather+Configuration.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 07/04/25.
//

import UIKit

enum Weather {
    struct Configuration {
        var strings = Strings()
        var constants = Constants()
    }
}

extension Weather.Configuration {
    struct Strings {
        let navigationTitle = NSLocalizedString("weather", comment: "")
        let detailNavigationTitle = "Detail Weather"
        let noInternetConnection = "Internet not available"
        let generalErrorTitle = "Something went wrong"

        // Localize
        let errorAlertTitle = NSLocalizedString("error_title", comment: "")
        let searchCityPlaceholder = NSLocalizedString("search_city", comment: "")
        let showDetailBtn = NSLocalizedString("show_details", comment: "")

        //Accessibility
        let searchTextAccessibility = "Search city to know the weather"
        let cityInfoAccessibility = "City  %@ in %@"
        let currentTempAccessibility = "Current temperature is %@ Celsius"
    }
}

extension Weather.Configuration {
    struct Constants {
        let baseUrl = "https://api.openweathermap.org/"
        let imageBaseUrl = "https://openweathermap.org/"
        let apiKey = "6d0c378c82f392beed318ed4a3d1e1a5"
        let basePath = "data/2.5/weather?"
        let zipCodePath = "geo/1.0/reverse?"
        let iconUrlPath = "img/wn/"
        let locationNotificationName = "PostLocationNotification"
    }
}
