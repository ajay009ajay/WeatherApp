//
//  Service.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation
import Combine
import UIKit


protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(endPoint: EndPoint, type: T.Type) async throws  -> T?
    func fetchWeatherIcon(endPoint: EndPoint) async -> UIImage?
}


struct NetworkService {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
}

extension NetworkService: NetworkServiceProtocol {
    func fetchData<T:Decodable>(endPoint: EndPoint, type: T.Type)async throws -> T? {        
        guard let urlRequest = endPoint.request else {
            throw WeatherError.invalidUrl(endPoint.path)
        }
        do {
            let (data, _) = try await session.data(for:urlRequest)
            let weatherResponse = try JSONDecoder().decode(T.self, from: data)
            FileSystemManager.writeToFile(response: data)
            return weatherResponse
        } catch {
            print("\(error)")
            throw WeatherError.parseError
        }
    }

    func fetchWeatherIcon(endPoint: EndPoint) async -> UIImage? {
        guard let urlRequest = endPoint.request else {
            return nil
        }
        if let url = urlRequest.url, let cachedImage = ImageCacheManager.shared.getImage(for: url) {
            return cachedImage
        }
        do {
            let (data, _) = try await session.data(for:urlRequest)
            if let image = UIImage(data: data), let url = urlRequest.url {
                ImageCacheManager.shared.cacheImage(image, for: url)
                return image
            }
        } catch {
            return nil
        }
        return nil
    }
}
