//
//  SEAnswer.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation

class SEAnswer {
    var score: Int?
    var body: String?
    let owner: SEOwner?
    let answers: [SEAnswer]?
    
    init(jsonDictionary: Dictionary<String, AnyObject>) {
        body = jsonDictionary["body"] as? String
        score = jsonDictionary["score"] as? Int

        if let ownerJson = jsonDictionary["owner"] as? Dictionary<String, AnyObject> {
            owner =  SEOwner(jsonDictionary: ownerJson)
        } else {
            owner = nil
        }
        
        if let jsonAnswers = jsonDictionary["answers"] as? Array<Dictionary<String, AnyObject>> {
            answers = SEAnswer.getAnswersWithJsonArray(jsonAnswers)
        } else {
            answers = nil
        }
    }
    
    
    
    // MARK: - Class functions
    
    class func getAnswerWithJsonString(_ jsonString: String) -> SEAnswer? {
        if let data = jsonString.data(using: .utf8) {
            return SEAnswer.getAnswerWithJsonData(data)
        }
        return nil
    }
    
    class func getAnswerWithJsonData(_ jsonData: Data) -> SEAnswer? {
        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, AnyObject> {
                
                let items = json["items"] as? Array<Dictionary<String, AnyObject>>
                
                if (items?.count)! > 0 {
                    return SEAnswer.init(jsonDictionary: (items?[0])!)
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
    
    class func getAnswersWithJsonArray(_ jsonArray: Array<Dictionary<String, AnyObject>>) -> [SEAnswer] {
        var answers = [SEAnswer]()
        
        for answerDictionary in jsonArray {
            let answer = SEAnswer(jsonDictionary: answerDictionary)
            answers.append(answer)
        }
        
        return answers
    }
}
