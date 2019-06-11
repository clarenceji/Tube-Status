//
//  LineRow.swift
//  LLDB
//
//  Created by Clarence Ji on 6/6/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import SwiftUI

struct LineRow : View {
    
    var line: Line
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(line.name + " Line")
                .font(.body)
            HStack(alignment: .center, spacing: 6) {
                Image(systemName:
                    self.line.isGoodService ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(line.isGoodService ? .green : .red)
                Text(line.shortStatus)
                    .font(.subheadline)
                    .color(line.isGoodService ? .green : .red)
                Spacer()
            }
            
            if !self.line.isGoodService {
                Text(self.line.reason ?? "")
                    .lineLimit(nil)
                    .font(.footnote)
            }
            
        }
            .padding([.top, .bottom], 6)
    }
}

#if DEBUG
struct LineRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            LineRow(line: lineData[0])
            LineRow(line: lineData[2])
        }
            .previewLayout(.fixed(width: 300, height: 130))
    }
}
#endif
