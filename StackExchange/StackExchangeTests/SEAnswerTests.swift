//
//  SEAnswerTests.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import StackExchange

class SEAnswerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAnswer() {
        
        // Load json file
        let jsonString = TestsHelper.readJsonFile("answers")
        let answer = SEAnswer.getAnswerWithJsonString(jsonString)
        XCTAssertNotNil(answer)
        
        // Check main answer
        XCTAssertEqual(answer?.score, 2)
        XCTAssertEqual(answer?.body, "<p>Elon Musk <a href=\"http://shitelonsays.com/transcript/elon-musk-at-mits-aeroastro-centennial-part-3-of-6-2014-10-24\" rel=\"nofollow noreferrer\">has suggested</a> that he\'d look at implementing VTOL electric aircraft with a \"gimballed thrust\" system similar to the one used in rockets.</p>\n\n<blockquote>\n  <p>Aircraft have all these unnecessary things like tails and rudders and elevators - not needed. Just gimbal.. anyway.. gimbal the electric fan. For some weird reason gimbaling motors is normal in rockets and not in aircraft. Why not? [Do you have specific plans?] I\'ve been sort of toying with the design for an electric supersonic vertical take-off and landing electric aircraft for a while, I\'d love to do it, but I think my mind would explode</p>\n</blockquote>\n\n<p>What are the challenges to implementing this? Is it technically feasible?</p>\n")
        XCTAssertEqual(answer?.owner?.displayName, "FloatingRock")
        XCTAssertEqual(answer?.owner?.profileImage, "https://i.stack.imgur.com/oZvCb.jpg?s=128&g=1")

        // Check subanswer
        if (answer?.answers?.count) == 1 {
            let subanswer = answer?.answers?[0]
            XCTAssertEqual(subanswer?.score, 2)
            XCTAssertEqual(subanswer?.body, "<p>Could you create an aircraft using an jet engine/propeller/ducted fan on a gimbal?  Sure you 'could'; it is feasible by the laws of physics.  But just because you can does not mean that you should.</p>\n\n<p>Setting up multiple points of lift on a manned aircraft seems like a good idea with a lot of advantages but is a Pandora's Box of problems, the not the least of which is the grave risks of single point failure.  Lift and control is totally reliant on balanced lift between multiple engines.  Lose one engine and the craft departs from controlled flight and crashes.  You better hope you have an ejection seat and/or parachute on board.</p>\n\n<p>Some solutions to these problems come in the form tiltrotor designs like the Agusta Westland 609 and the V-22.  But these aircraft have multiple redundancies in their design including a common transmission system between the rotors; in case of a single engine failure, the good engine has enough power to drive both rotors.  Tiltrotors can also glide like regular airplanes and utilize control surfaces during this and cruise flight.</p>\n\n<p>As a final note:  Be careful in putting too much faith in Musk and other Silicon Valley whiz kids speculating about other design endeavors.  The skills required to run a successful software company are often very different from that required to develop other artifacts like aircraft and automobiles, etc.  Musk was a genius with PayPal but nearly went bankrupt starting an electric car company and his development work with SpaceX has been punctuated with a series of spectacular failures.  He also quietly withdrew from his proposed 'Hyperloop' project, I suspect, because he really didn't understand what he was getting into there.</p>\n")
            XCTAssertEqual(subanswer?.owner?.displayName, "Carlo Felicione")
            XCTAssertEqual(subanswer?.owner?.profileImage, "https://lh6.googleusercontent.com/-jdMFM24ZQRc/AAAAAAAAAAI/AAAAAAAAABM/XMsy0U7LUzc/photo.jpg?sz=128")
        } else {
            XCTFail()
        }
    }
    
}
