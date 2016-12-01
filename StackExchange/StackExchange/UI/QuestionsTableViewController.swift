//
//  QuestionsTableViewController.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController, PresenterDelegate {
    
    let presenter = Presenter.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.questionsDelegate = self
        presenter.pullUpdates()
        self.navigationItem.title = "Questions"
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Presenter methods
    
    func presenterDataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presenterError(errorMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            }
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionTableViewCell

        if presenter.questions.count > indexPath.row {
            let question = presenter.questions[indexPath.row]
            cell?.setQuestionData(question)
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = presenter.questions[indexPath.row]
        presenter.requestAnswer(questionId: question.questionId!)
        performSegue(withIdentifier: "showDetails", sender: self)
    }

}
