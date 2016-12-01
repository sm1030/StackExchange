//
//  AnswersTableViewController.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 01/12/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class AnswersTableViewController: UITableViewController, PresenterDelegate {

    let presenter = Presenter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.answersDelegate = self
        self.navigationItem.title = "Answers"
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        label.backgroundColor = UIColor.green
        label.textAlignment = .center
        label.text = section==0 ? "Best Answer" : "Other Answers"
        return label
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.answer?.answers != nil ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let rows = presenter.answer == nil ? 0 : 1
            return rows
        } else {
            let rows = (presenter.answer?.answers?.count) ?? 0
            return rows
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerTableViewCell
        
        if indexPath.section == 0 {
            let answer = presenter.answer
            cell?.setAnswerData(answer!)
        } else {
            if (presenter.answer?.answers?.count)! > indexPath.row {
                let answer = presenter.answer?.answers?[indexPath.row]
                cell?.setAnswerData(answer!)
            }
        }
        
        return cell!
    }

}
