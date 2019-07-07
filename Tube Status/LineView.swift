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
            
            List {
                
                if !model.isFetching {
                    ForEach(model.lines) { line in
                        NavigationLink(destination: LineDetail(line: line, model: StationModel())) {
                            LineRow(line: line)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Tube Status"), displayMode: .large)
            
            .navigationBarItems(trailing: Button(action: {
                self.model.fetch()
                self.model.isFetching = true
            }, label: {
                Image(systemName: "arrow.2.circlepath")
            }))
            
        }
        .onAppear {
            self.model.fetch()
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
