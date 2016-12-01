//
//  QuestionTableViewCell.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    var question: SEQuestion?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionData(_ question: SEQuestion) {
        
        self.question = question
        
        showTitle()
        showImage()
        showScoreAnswers()
        showTags()
    }
    
    func showTitle() {
        titleLabel.text = question?.title?.replacingOccurrences(of: "&#39;", with: "'").replacingOccurrences(of: "&quot;", with: "\"")
//        if let data = question?.title?.data(using: .utf8) {
//            do {
//                let attrStr = try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
//                titleLabel.attributedText = attrStr
//            }
//            catch {
//                
//            }
//        }
    }
    
    func showImage() {
        if let imageUrl = question?.owner?.profileImage {
            if let imageData = Presenter.sharedInstance.getImageData(imageUrl: imageUrl){
                profileImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    func showScoreAnswers() {
        scoreLabel.text = "\((question?.score)!) / \((question?.answerCount)!)"
    }
    
    func showTags() {
        var text = "( "
        
        for i in 0...(question?.tags?.count)!-1 {
            if i > 0 {
                text += ", "
            }
            text += (question?.tags?[i])!
        }
        
        text += " )"
        tagsLabel.text = text
    }
    

}
