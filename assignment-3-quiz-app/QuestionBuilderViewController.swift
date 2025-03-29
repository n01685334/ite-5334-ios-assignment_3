//
//  QuestionBuilderViewController.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import UIKit

class QuestionBuilderViewController: UIViewController, QuizBuilderDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    var currentQuestion: Question?
    
    func addQuestionDidFail(reason: String) {
        errorLabel.text = reason
    }

    var quizManager: QuizManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currentQuestion == nil) {
            titleLabel.text = "Question Builder"
        } else {
            titleLabel.text = "Question Editor"
        }
        
        quizManager = QuizManager.shared
        errorLabel.text = ""
        QuizManager.shared.quizBuilderDelegate = self
        
        if let currentQuestion {
            questionTextField.text = currentQuestion.questionText
            correctQuestionTextField.text = currentQuestion.correctAnswer
            incorrectQField1.text = currentQuestion.incorrectAnswers[0]
            incorrectQField2.text = currentQuestion.incorrectAnswers[1]
            incorrectQField3.text = currentQuestion.incorrectAnswers[2]
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated:true)
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var correctQuestionTextField: UITextField!
    
    @IBOutlet weak var incorrectQField1: UITextField!
    
    @IBOutlet weak var incorrectQField2: UITextField!
    
    @IBOutlet weak var incorrectQField3: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func doneBtn(_ sender: Any) {
        if(
            questionTextField.text?.isEmpty ?? false ||
            correctQuestionTextField.text?.isEmpty ?? false ||
            incorrectQField1.text?.isEmpty ?? false ||
            incorrectQField2.text?.isEmpty ?? false ||
            incorrectQField3.text?.isEmpty ?? false
        ) {
            errorLabel.text = "You must complete all fields."
            return;
        }
        
        if(!checkUnique()) {
            errorLabel.text = "All answer fields must be unique."
            return;
        }
        
        let success: Bool
        
        if let currentQuestion = currentQuestion {
            success = quizManager?.updateQuestion(
                        questionID: currentQuestion.questionID,
                        questionText: questionTextField.text!,
                        correctAnswer: correctQuestionTextField.text!,
                        incorrectAnswers: [incorrectQField1.text!, incorrectQField2.text!, incorrectQField3.text!]
                    ) ?? false
        } else {
            success = quizManager?.addQuestion(questionText: questionTextField.text!, correctAnswer: correctQuestionTextField.text!, incorrectAnswers: [incorrectQField1.text!, incorrectQField2.text!, incorrectQField3.text!]) ?? false
        }
        
        
        
        if success {
            dismiss(animated:true)
        }
        
        
    }
    
    
    func checkUnique() -> Bool
    {
        let answers: [String] = [
            correctQuestionTextField.text ?? "",
            incorrectQField1.text ?? "",
            incorrectQField2.text ?? "",
            incorrectQField3.text ?? ""
        ]
        
        let answerSet = Set(answers)
        
        return answerSet.count == answers.count
        
    }

    
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
