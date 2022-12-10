//
//  ContentModel.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 01/12/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    //Current Module
    
    @Published var currentModule: Module?
    
    var currrentModuleIndex = 0
    
    //Current Lesson
    
    @Published var currentLesson: Lesson?
    
    var currentLessonIndex = 0
    
   //Current Question
    
    @Published var currentQuestion:Question?
    
    var currentQuestionIndex = 0
    
    //Current Lesson Explanation
    
    @Published var codeText = NSAttributedString()
    
    
    var styleData: Data?
    
    //Current selected content and test
    
    @Published var currentContentSelected:Int?
    
    @Published var currentTestSelected: Int?
    
    
    
    
    
    init() {
        
        getLocalData()
        
        
        
    }
    //MARK: - Data Methods
    
    func getLocalData() {
        
        
       let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        do {
        let jsonData = try Data(contentsOf: jsonUrl!)
            
        let jsonDecoder = JSONDecoder()
            
        let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
        self.modules = modules
            
        }
        catch {
            
            print("Couldn't parse local data")
            
            
        }
        
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        }
        catch {
            
            print("Couldn't parse local data")
            
            
        }
        
        
        
        
        
        
    }
    
 
    //MARK: - Module Navigation Methods
    
    func beginModule( moduleid: Int) {
        
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                
                currrentModuleIndex = index
                break
                
                
            }
            
            
            
            
            
        }
        
        
        currentModule = modules[currrentModuleIndex]
        
        
        
    }
    
    
    
    func beginLesson ( lessonIndex: Int) {
        
        
        if lessonIndex < currentModule!.content.lessons.count {
            
            
            currentLessonIndex = lessonIndex
            

            
        }
        else {
            
            currentLessonIndex = 0
            
            
        }
        
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(htmlString: currentLesson!.explanation)
        
    }
    func nextLesson() {
        
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(htmlString: currentLesson!.explanation)
            
            
        }
        else {
            
            
            //Reset the lesson state
            
            currentLesson = nil
            currentLessonIndex = 0
            
            
            
        }
        
    }
        
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        
    }
    
    func beginTest(moduleId: Int) {
        
        //Set the current module
        
        beginModule(moduleid: moduleId)
        
        //Set the current question
        
        
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(htmlString: currentQuestion!.content)
            
            
        }
        
        
        
    }
    
    //MARK: - Code styling
    
    
    private func addStyling ( htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data
        
        if styleData != nil {
        data.append(styleData!)
        
        }
        //Add the html data
        data.append(Data(htmlString.utf8))
        
        
        //Convert to attributed string
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
            
            
            
        }
        
        
     
        
        
        
        return resultString
        
        
        
        
        
    }
    
    
}

    
