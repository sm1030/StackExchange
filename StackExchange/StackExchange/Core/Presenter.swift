//
//  Presenter.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

protocol PresenterDelegate: class {
    func presenterDataUpdated()
    func presenterError(errorMessage: String)
}

class Presenter: ApiServiceDelegate {
    
    static let sharedInstance = Presenter()
    
    weak var questionsDelegate: PresenterDelegate?
    weak var answersDelegate: PresenterDelegate?
    var api: ApiService?
    var questionId = 0
    var questions = [SEQuestion]()
    var answer: SEAnswer?
    
    func pullUpdates() {
        if api == nil {
            api = ApiService(delegate: self)
        }
        
        api?.requestQuestions()
    }
    
    func getImageData(imageUrl: String) -> Data? {
        let data = SEData.getData(forURL: imageUrl)
        
        if data == nil {
            api?.requestImage(image_url: imageUrl)
        }
        
        return data
    }
    
    func requestAnswer(questionId: Int) {
        self.questionId = questionId
        answer = nil
        api?.requestAnswers(questionId: questionId)
    }
    
    func apiServiceQuestionsReceived(questions: [SEQuestion]) {
        self.questions = questions
        questionsDelegate?.presenterDataUpdated()
    }
    
    func apiServiceAnswerReceived(answer: SEAnswer) {
        self.answer = answer
        answersDelegate?.presenterDataUpdated()
    }
    
    func apiServiceDataImageReceived() {
        questionsDelegate?.presenterDataUpdated()
        answersDelegate?.presenterDataUpdated()
    }
    
    func apiServiceError(errorMessage: String) {
        questionsDelegate?.presenterError(errorMessage: errorMessage)
        answersDelegate?.presenterError(errorMessage: errorMessage)
    }

}
