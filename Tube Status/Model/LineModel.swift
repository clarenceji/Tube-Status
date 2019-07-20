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
    
    let willChange = PassthroughSubject<LineModel, Never>()
    
    var lines: [Line] = [] {
        didSet {
            willChange.send(self)
            isFetching = false
        }
    }
    
    var isFetching: Bool = false {
        didSet {
            willChange.send(self)
        }
    }
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    func fetch() {
        
        _ = TfLService.loadTubeStatus()
            .sink(receiveValue: { (lines) in
                DispatchQueue.main.async { [weak self] in
                    self?.lines = lines
                }
            })
        
    }
    
}
