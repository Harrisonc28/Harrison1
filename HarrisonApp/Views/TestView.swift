//
//  TestView.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 09/12/2022.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
    
        if model.currentQuestion != nil {
        
            VStack(alignment: .leading) {
             
            //Question Number
            Text("Question \(model.currentLessonIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
            //Question
                CodeTextView().padding(.horizontal, 20)
            
            //Answer
                ScrollView {
                    
                    VStack {
                        
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            
                            Button {
                                
                                //Track the selected index
                                selectedAnswerIndex = index
                                
                                
                            } label: {
                                
                                ZStack {
                                    
                                    if submitted == false {
                                    RectangleCard(color: index == selectedAnswerIndex ? .gray : .white).frame(height: 48)
                                        
                                    }
                                    else {
                                        
                                        //Answer has been submitted
                                        
                                        if (index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex) || index == model.currentQuestion!.correctIndex  {
                                            
                                            //User has selected the right answer
                                            //Show a green background
                                            RectangleCard(color: Color.green).frame(height: 48)
                                            
                                            
                                        }
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            
                                            RectangleCard(color: Color.red).frame(height: 48)
                                            
                
                                        }
                                       
                                        else {
                                            
                                            RectangleCard(color: .white).frame(height: 48)
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    Text(model.currentQuestion!.answers[index])
                               
      
                                }
                                
                                
                            }
                            .disabled(submitted)
                          
                            
                        }
                        
                        
                    }.padding()
                        .accentColor(.black)
                    
                    
                    
                    
                    
                    
                    
                    
                }
            
                Button {
                    
                    //Change the submitted state to true
                    
                    submitted = true
                    
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        
                        
                        numCorrect += 1
                        
                        
                    }
                    
                    
                } label: {
                    ZStack {
                    RectangleCard(color: .green).frame(height: 48)
                    
                    Text("Submit").bold().foregroundColor(.white)
                        
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
            
            
            
            
        }
        .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        
        }
        else {
            
            ProgressView()
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
