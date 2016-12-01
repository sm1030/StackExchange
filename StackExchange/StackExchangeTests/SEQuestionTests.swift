//
//  SEQuestionTests.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import StackExchange

class SEQuestionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQuestion() {
        
        // Load json file
        let jsonString = TestsHelper.readJsonFile("questions")
        let questions = SEQuestion.getQuestionsWithJsonString(jsonString)
        
        // Check questions if it counts to 30
        if questions?.count == 30 {
            
            // Check first question
            XCTAssertEqual(questions?[0].score, 7)
            XCTAssertEqual(questions?[0].questionId , 33535)
            XCTAssertEqual(questions?[0].answerCount , 4)
            XCTAssertEqual(questions?[0].title, "What is this aircraft with elaborate folding wings?")
            XCTAssertEqual(questions?[0].tags?[0], "aircraft-identification")
            XCTAssertEqual(questions?[0].owner?.displayName, "tallpaul")
            XCTAssertEqual(questions?[0].owner?.profileImage, "https://www.gravatar.com/avatar/6375ef343bd60cda8a749fb9fd5b20c5?s=128&d=identicon&r=PG&f=1")
            
            // Check last question
            XCTAssertEqual(questions?[29].score, 5)
            XCTAssertEqual(questions?[29].questionId , 33430)
            XCTAssertEqual(questions?[29].answerCount , 3)
            XCTAssertEqual(questions?[29].title, "Why are most runways made of asphalt and not concrete?")
            XCTAssertEqual(questions?[29].tags?[0], "runways")
            XCTAssertEqual(questions?[29].tags?[1], "airport-design")
            XCTAssertEqual(questions?[29].owner?.displayName, "shirish")
            XCTAssertEqual(questions?[29].owner?.profileImage, "https://www.gravatar.com/avatar/e800f46627112c8eaec0947e4ce88c8b?s=128&d=identicon&r=PG&f=1")
        } else {
            XCTFail()
        }
    }
    
}
