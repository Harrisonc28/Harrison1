//
//  ContentView.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 05/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            
            LazyVStack {
            
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
        
                
                        NavigationLink(destination: ContentDetailView().onAppear(perform: {
                            model.beginLesson(lessonIndex: index)
                        }), label: { ContentViewRow(index: index) })
                
            }
                
                
                
            }
                
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
