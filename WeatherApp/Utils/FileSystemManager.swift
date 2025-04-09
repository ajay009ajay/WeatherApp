//
//  FileManager.swift
//  WeatherApp
//
//  Created by Ajay Kumar Singh on 08/04/25.
//

import Foundation

struct FileSystemManager {
    static func writeToFile(response: Data) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let fileURL = documentDirectory.appendingPathComponent("weather.txt")
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
                print("Old data deleted successfully.")
            }
            try response.write(to: fileURL)
        } catch {
            print("Error writing to file: \(error)")
        }
    }

    static func readFromFile() -> WeatherResponseModel? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent("weather.txt")
        do {
            let savedData = try Data(contentsOf: fileURL)
            let response = try JSONDecoder().decode(WeatherResponseModel.self, from: savedData)
            return response
        } catch {
            print("Error reading from file: \(error)")
            return nil
        }
    }
}
