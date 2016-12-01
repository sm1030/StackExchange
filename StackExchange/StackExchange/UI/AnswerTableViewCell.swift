//
//  AnswersTableViewCell.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var htmlLabel: UILabel!

    var answer: SEAnswer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setAnswerData(_ answer: SEAnswer) {
        
        self.answer = answer
        
        showImage()
        showUsername()
        showScore()
        showBody()
    }
    
    func showImage() {
        if let imageUrl = answer?.owner?.profileImage {
            if let imageData = Presenter.sharedInstance.getImageData(imageUrl: imageUrl){
                profileImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func showUsername() {
        usernameLabel.text = answer?.owner?.displayName
    }
    
    func showScore() {
        scoreLabel.text = "\((answer?.score)!)"
    }
    
    func showBody() {
        if let data = answer?.body?.data(using: .utf8) {
            do {
                let attrStr = try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                htmlLabel.attributedText = attrStr
            }
            catch {
                
            }
        }
    }

}
