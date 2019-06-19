//
//  TfLService.swift
//  Tube Status
//
//  Created by Clarence Ji on 6/8/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import Foundation
import Combine

struct TfLService {
    
    static let timeoutInterval: TimeInterval = 10.0
    static let baseURL = URL(string: "https://api.tfl.gov.uk")!
    
    static func loadTubeStatus() -> AnyPublisher<[Line], Never> {

        let endpoint = baseURL.appendingPathComponent("Line/Mode/tube/Status")
        var request = URLRequest(url: endpoint, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: [Line].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()

    }
    
}
