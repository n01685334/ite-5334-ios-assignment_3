//
//  QuestionTableViewController.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import UIKit

class QuestionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuizDelegate {
    
    var questionList: [Question] = []
    
    func didAddQuestion(questions: [Question]) {
        questionList = questions
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question Bank"
        questionList = QuizManager.shared.getAllQuestions()
        QuizManager.shared.quizManagerDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 350

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questioncell", for: indexPath) as! QuestionTableCell
        
        let question = questionList[indexPath.row]
        
        cell.questionNumberLabel.text = "Question \(indexPath.row + 1)"
        cell.questionTextLabel.text = question.questionText
        cell.correctAnswerLabel.text = question.correctAnswer
        cell.incorrectAnswer1Label.text = question.incorrectAnswers[0]
        cell.incorrectAnswer2Label.text = question.incorrectAnswers[1]
        cell.incorrectAnswer3Label.text = question.incorrectAnswers[2]
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tableCellSegue") {
            if let builderVC = segue.destination as? QuestionBuilderViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    builderVC.currentQuestion = questionList[indexPath.row]
                    builderVC.title = "Question Editor"
                }
            }
            
        }
    }

}
