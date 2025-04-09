//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation

enum WeatherError: LocalizedError, Equatable {
    case dataError(statusCode: Int, data: Data?)
    case unexpected
    case noInternetConnection
    case invalidUrl(String)
    case parseError

    var errorDescription: String? {
        let configuration = Weather.Configuration()
        return switch self {
        case .noInternetConnection:
            configuration.strings.noInternetConnection
        case .unexpected, .dataError, .invalidUrl, .parseError:
            configuration.strings.generalErrorTitle
        }
    }
}
