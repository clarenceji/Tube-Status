//
//  StationModel.swift
//  Tube Status
//
//  Created by Clarence Ji on 6/19/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import SwiftUI
import Combine

final class StationModel: BindableObject {
    
    let didChange = PassthroughSubject<StationModel, Never>()
    
    var stations: [Station] = [] {
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
    
    func fetch(line: Line) {
        
        _ = TfLService.loadStations(on: line)
            .sink(receiveValue: { (stations) in
                DispatchQueue.main.async { [weak self] in
                    self?.stations = stations
                }
            })
        
    }
    
}
