//
//  WeatherService.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
}

class WeatherService {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
