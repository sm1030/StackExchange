//
//  SEQuestion.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation

class SEQuestion {
    let score: Int?
    let answerCount: Int?
    let title: String?
    let tags: [String]?
    let owner: SEOwner?
    
    init(jsonDictionary: Dictionary<String, AnyObject>) {
        score = jsonDictionary["score"] as? Int
        answerCount = jsonDictionary["answer_count"] as? Int
        title = jsonDictionary["title"] as? String
        tags = jsonDictionary["tags"] as? Array<String>
        
        if let ownerJson = jsonDictionary["owner"] as? Dictionary<String, AnyObject> {
            owner =  SEOwner(jsonDictionary: ownerJson)
        } else {
            owner = nil
        }
    }
    
    
    
    // MARK: - Class functions
    
    class func getQuestionsWithJsonString(_ jsonString: String) -> [SEQuestion]? {
        if let data = jsonString.data(using: .utf8) {
            return SEQuestion.getQuestionsWithJsonData(data)
        }
        return nil
    }
    
    class func getQuestionsWithJsonData(_ jsonData: Data) -> [SEQuestion]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, AnyObject> {
                
                if let items = json["items"] as? Array<Dictionary<String, AnyObject>> {
                    var questions = [SEQuestion]()
                    for item in items {
                        let question = SEQuestion(jsonDictionary: item)
                        questions.append(question)
                    }
                    return questions
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
}
