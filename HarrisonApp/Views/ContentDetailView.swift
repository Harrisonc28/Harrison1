//
//  ContentDetailView.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 05/12/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    
    var body: some View {
        
        let lesson = model.currentLesson
    
        
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        
        
        VStack {
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!)).cornerRadius(10)
        }
        
        //TODO: Description
        
            CodeTextView()
        
        //Next Lesson
            if model.hasNextLesson() {
            
                Button(action: {
                    //Advance the lesson
                    
                    model.nextLesson()
                    
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green).frame(height: 48)
            
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)").foregroundColor(Color.white).bold()
                        
                    }
            })
               

            
            }
            else {
                
                //Show the complete button instead
                
                Button(action: {
                    //Take the user back to the homeview
                    
                    model.currentContentSelected = nil
                    
                    
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green).frame(height: 48)
            
                        Text("Completed").foregroundColor(Color.white).bold()
                        
                    }
            })
                
                
            }
        }
        .navigationBarTitle(lesson?.title ?? "")
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
