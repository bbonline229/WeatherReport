//
//  URL+Extension.swift
//  GoodNews
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        components?.queryItems = queries.map({
            URLQueryItem(name: $0.key, value: $0.value)
        })
        
        return components?.url
    }
}
