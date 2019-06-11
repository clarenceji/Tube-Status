//
//  LineView.swift
//  LLDB
//
//  Created by Clarence Ji on 6/5/19.
//  Copyright © 2019 Clarence Ji. All rights reserved.
//

import SwiftUI

struct LineView : View {
    
    @ObjectBinding var model: LineModel
    
    var body: some View {
        
        NavigationView {
            
            Text("")
                .navigationBarItems(trailing: Button(action: {
                    self.model.fetch()
                    self.model.isFetching = true
                }, label: {
                    Text("Refresh")
                }))
            
            List {
                if !model.isFetching {
                    ForEach(model.lines) { line in
                        LineRow(line: line)
                    }
                }
            }
                .navigationBarTitle(Text("Tube Status"), displayMode: .large)
                
        }
        
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        LineView(model: LineModel())
    }
}
#endif