//
//  LineModel.swift
//  LLDB
//
//  Created by Clarence Ji on 6/6/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import SwiftUI
import Combine

final class LineModel: BindableObject {
    
    let didChange = PassthroughSubject<LineModel, Never>()
    
    var lines: [Line] = [] {
        didSet {
            didChange.send(self)
            isFetching = false
        }
    }
    
    var isFetching: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    func fetch() {
        
        let url = URL(string: "https://api.tfl.gov.uk/Line/Mode/tube/Status")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let assign = Subscribers.Assign(object: self, keyPath: \.lines)
        cancellable = assign
        
        URLSession.shared.send(request: request)
            .map { $0.data }
            .decode(type: [Line].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(subscriber: assign)
        
    }
    
}
