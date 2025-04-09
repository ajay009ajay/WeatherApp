//
//  DetailWeather+Configuration.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import UIKit

enum DetailWeather {
    struct Configuration {
        var strings = Strings()
    }
}
extension DetailWeather.Configuration {
    struct Strings {
        let detailTemperature = NSLocalizedString("detail_temperature", comment: "")
        let humidity = NSLocalizedString("humidity", comment: "")
        let minimumTemp = NSLocalizedString("minimum_temp", comment: "")
        let visibility = NSLocalizedString("visibility", comment: "")
    }
}
