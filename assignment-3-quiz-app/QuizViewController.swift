//
//  QuizViewController.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import UIKit

class QuizViewController: UIViewController, QuizResultDelegate {
    
    
    
    @IBOutlet weak var btn1Outlet: UIButton!
    @IBOutlet weak var btn2Outlet: UIButton!
    @IBOutlet weak var btn3Outlet: UIButton!
    @IBOutlet weak var btn4Outlet: UIButton!

    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerTextA: UILabel!
    @IBOutlet weak var answerTextB: UILabel!
    @IBOutlet weak var answerTextC: UILabel!
    @IBOutlet weak var answerTextD: UILabel!
    
    @IBOutlet weak var prevBtnOutlet: UIButton!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    @IBOutlet weak var submitBtnOutlet: UIButton!
    
    @IBOutlet weak var answerCountOutlet: UILabel!
    @IBOutlet weak var questionLabelOutlet: UILabel!
    
    @IBOutlet weak var progressOutlet: UIProgressView!
    
    var radioButtons: [UIButton] = []
    var quizManager: QuizManager?
    var questionList: [Question] = []
    var currentQuestionIndex = 0
    var shuffledAnswers: [String] = []
    var currentQuestion: Question?
    var currentQuestionID: UUID?
    var answerLabels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Quiz"
        
        quizManager = QuizManager.shared
        questionList = quizManager?.getAllQuestions() ?? []
        radioButtons = [btn1Outlet, btn2Outlet, btn3Outlet, btn4Outlet]
        answerLabels = [answerTextA, answerTextB, answerTextC, answerTextD]
        renderQuiz(shouldReshuffle: true)
    }
    
    func didFinishQuiz() {
        quizManager?.resetUserAswers()
        currentQuestionIndex = 0
        renderQuiz(shouldReshuffle: true)
    }

    func renderQuiz(shouldReshuffle: Bool = false) {
        if(questionList.count == 0) {
            return;
        }
        
        currentQuestion = questionList[currentQuestionIndex]
        currentQuestionID = currentQuestion?.questionID
        
        if let id = currentQuestionID {
            if(shouldReshuffle) {
                shuffledAnswers = quizManager?.quiz.getRandomizedAnswers(questionID: id) ?? []
            }
        }
        
        if(shuffledAnswers.count == 0) {
            return;
        }
        
        prevBtnOutlet?.isEnabled = currentQuestionIndex != 0
        nextBtnOutlet?.isEnabled = currentQuestionIndex < questionList.count - 1
        
        let currentProgress = Float(currentQuestionIndex + 1) / Float(questionList.count)
        progressOutlet.setProgress(currentProgress, animated: true)
        
        questionLabelOutlet.text = "Question \(currentQuestionIndex + 1):"
        
        if(currentQuestionIndex < questionList.count) {
            
            questionText.text = currentQuestion?.questionText
            
            answerTextA.text = shuffledAnswers[0]
            answerTextB.text = shuffledAnswers[1]
            answerTextC.text = shuffledAnswers[2]
            answerTextD.text = shuffledAnswers[3]
        }
        
        for btn in radioButtons {
            applyButtonStyle(btn)
        }
        
        if let existingAnswer = quizManager?.quiz.userAnswers[currentQuestionID!] {
            let selectedAnswerLabelIndex = shuffledAnswers.firstIndex(of: existingAnswer.answerText)
            
            applySelectedButtonStyle(radioButtons[selectedAnswerLabelIndex!])

        }
        
        let userAnswerCount = quizManager?.quiz.userAnswers.count ?? 0
        answerCountOutlet.text = "Questions Answered: \(userAnswerCount) of \(questionList.count)"
        
        if(userAnswerCount == questionList.count) {
            submitBtnOutlet.isHidden = false
        }
        
        
    }
    
    
    func applyButtonStyle(_ button: UIButton) {
        button.setTitle("", for: .normal)
        button.layer.borderWidth = 2
        button.frame.size.width = 30
        button.frame.size.height = 30
        button.layer.cornerRadius = button.frame.size.height / 2
        button.backgroundColor = UIColor.white
    }
    
    func applySelectedButtonStyle(_ button: UIButton) {
        
        button.backgroundColor = UIColor.blue
    }
    
    @IBAction func radioBtnTapped(_ sender: UIButton) {
                
        let btnIndex = radioButtons.firstIndex(of: sender) ?? -1
        if(btnIndex >= 0) {
            let selectedAnswer: String = shuffledAnswers[btnIndex]
                print("selected answer: \(shuffledAnswers[btnIndex])")
            
            quizManager?.quiz.recordAnswer(answerText: selectedAnswer, questionID: currentQuestionID!)
            
        }
        
        renderQuiz()
    }
    
    
    @IBAction func prevBtnAction(_ sender: Any) {
        currentQuestionIndex = currentQuestionIndex - 1
        renderQuiz(shouldReshuffle: true)
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        currentQuestionIndex = currentQuestionIndex + 1
        renderQuiz(shouldReshuffle: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "resultSegue") {
            if let resultVC = segue.destination as? QuizResultViewController {
                resultVC.quizResult = quizManager?.getQuizResultText() ?? "Unknown"
                resultVC.delegate = self
            }
            
        }
    }
}
