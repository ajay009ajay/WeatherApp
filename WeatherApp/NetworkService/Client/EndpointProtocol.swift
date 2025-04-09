//
//  EndpointProtocol.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation

protocol EndPointProtocol {
    var path: String { get }
    var method: String { get }
    var request: URLRequest? { get }
}

enum EndPoint: EndPointProtocol {
    case weather(String, String, String)
    case icon(String)
    case latLong(String, String)

    var path: String {
        let constant = Weather.Configuration().constants
        switch self {
        case .weather:
            return "\(constant.baseUrl)\(constant.basePath)"
        case .icon(let iconName):
            return "\(constant.imageBaseUrl)\(constant.iconUrlPath)\(iconName).png"
        case .latLong:
            return "\(constant.baseUrl)\(constant.zipCodePath)"
        }
    }
    var method: String {
        switch self {
        case .weather, .icon, .latLong:
            "GET"
        }
    }
    var request: URLRequest? {
        guard var components = URLComponents(string: self.path) else {
            return nil
        }
        switch self {
        case .weather(let cityName, let state, let countryCode):
            components.queryItems = [
                URLQueryItem(name: "q", value: "\(cityName),\(state),\(countryCode)"),
                URLQueryItem(name: "appid", value: Weather.Configuration().constants.apiKey)
            ]
        case .icon:
            components.queryItems = []
        case .latLong(let lat, let long):
            components.queryItems = [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: long),
                URLQueryItem(name: "appid", value: Weather.Configuration().constants.apiKey)
            ]
        }
        guard let url = components.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }
}
