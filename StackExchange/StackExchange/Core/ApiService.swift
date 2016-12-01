//
//  ApiService.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiServiceDelegate: class {
    func apiServiceQuestionsReceived(questions: [SEQuestion])
    func apiServiceAnswersReceived(answers: SEAnswer)
    func apiServiceDataImageReceived()
    func apiServiceError(errorMessage: String)
}

class ApiService {
    
    weak var delegate: ApiServiceDelegate?
    
    init(delegate: ApiServiceDelegate) {
        self.delegate = delegate
    }
    
    func requestQuestions() {
        Alamofire.request("https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=aviation").responseJSON { response in
            var errorMessage: String? = "Network response contain no value"
            if let _ = response.result.value {
                errorMessage = "Network response contain no data"
                if let data = response.data {
                    errorMessage = "Questions couldn't be extracted from response"
                    if let questions = SEQuestion.getQuestionsWithJsonData(data) {
                        errorMessage = nil
                        self.delegate?.apiServiceQuestionsReceived(questions: questions)
                    }
                }
            }
            
            if errorMessage != nil {
                self.delegate?.apiServiceError(errorMessage: errorMessage!)
            }
        }
    }
    
    func requestAnswers(questionId: Int) {
        let url = " https://api.stackexchange.com/2.2/questions/\(questionId)?order=desc&sort=activity&site=aviation&filter=!-*f(6rc.(Xr5"
        Alamofire.request(url).responseJSON { response in
            var errorMessage: String? = "Network response contain no value"
            if let _ = response.result.value {
                errorMessage = "Network response contain no data"
                if let data = response.data {
                    errorMessage = "Answers couldn't be extracted from response"
                    if let answer = SEAnswer.getAnswerWithJsonData(data) {
                        errorMessage = nil
                        self.delegate?.apiServiceAnswersReceived(answers: answer)
                    }
                }
            }
            
            if errorMessage != nil {
                self.delegate?.apiServiceError(errorMessage: errorMessage!)
            }
        }
    }
    
    func requestImage(image_url: String?) {
        if image_url != nil {
            Alamofire.request(image_url!).responseData(completionHandler: { (dataResponse: DataResponse<Data>) in
                var errorMessage: String? = "Network response contain no data"
                if let data = dataResponse.data {
                    errorMessage = nil
                    SEData.saveData(data: data, forURL: image_url!)
                    self.delegate?.apiServiceDataImageReceived()
                }
                
                if errorMessage != nil {
                    self.delegate?.apiServiceError(errorMessage: errorMessage!)
                }
            })
        }
    }
    
}
