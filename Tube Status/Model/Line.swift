//
//  Line.swift
//  LLDB
//
//  Created by Clarence Ji on 6/6/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import SwiftUI

struct Line: Hashable, Codable, Identifiable {
    
    var id: String
    var name: String
    var lineStatuses: [Status]
    
    struct Status: Hashable, Codable, Identifiable {
        var id: Int
        var statusSeverity: Int
        var statusSeverityDescription: String
        var reason: String?
    }
    
    var isGoodService: Bool {
        return shortStatus.lowercased() == "good service"
    }
    
    var shortStatus: String {
        return topStatus?.statusSeverityDescription ?? ""
    }
    
    var reason: String? {
        return topStatus?.reason ?? ""
    }
    
    private var topStatus: Status? {
        return lineStatuses.sorted(by: { $0.statusSeverity < $1.statusSeverity }).first
    }
    
}
