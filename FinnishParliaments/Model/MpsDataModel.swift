//
//  MpsDataModel.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.

import Foundation

// Manages data loading for Members of Parliament (MPs).
class MpsDataLoader {
    // The remote URL to fetch the MPs data.
    static let urlString = "https://users.metropolia.fi/~peterh/mps.json"

    // Local file URL to save and retrieve the MPs data.
    static let fileURL: URL = {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("mps.json")
    }()

    // Fetches the MPs data from the remote URL.
    // Parameter completion: A closure that returns an array of `Member` objects or `nil` in case of failure.
    static func loadRemoteMps(completion: @escaping ([Member]?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response from server")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                // Decode the JSON into an array of Member objects.
                let mps = try JSONDecoder().decode([Member].self, from: data)
                // Save the fetched MPs locally.
                saveMps(mps)
                // Return the fetched MPs via the completion handler.
                DispatchQueue.main.async {
                    completion(mps)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }

    // Saves the MPs data locally to the file system.
    // Parameter mps: The array of `Member` objects to be saved.
    static func saveMps(_ mps: [Member]) {
        do {
            let data = try JSONEncoder().encode(mps)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save MPs locally: \(error)")
        }
    }

    // Loads the MPs data from local storage.
    // Returns: An optional array of `Member` objects if loading succeeds, or `nil` otherwise.
    static func loadLocalMps() -> [Member]? {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Member].self, from: data)
        } catch {
            print("Failed to load MPs locally: \(error)")
            return nil
        }
    }

    // Fetches MPs, attempting local data first, then falling back to remote if needed.
    // Parameter completion: A closure returning the MPs as an array or `nil` on failure.
    static func loadMps(completion: @escaping ([Member]?) -> Void) {
        // Attempt to load locally saved MPs.
        if let localMps = loadLocalMps() {
            print("Loaded MPs from local storage.")
            completion(localMps)
        } else {
            print("Local MPs data unavailable, fetching from remote...")
            loadRemoteMps(completion: completion)
        }
    }
}
