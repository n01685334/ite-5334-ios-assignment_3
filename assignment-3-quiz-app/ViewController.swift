//
//  ViewController.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var takeQuizBtnOutlet: UIButton!
    var quizManager: QuizManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizManager = QuizManager.shared
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guardQuiz()
    }
    
    func guardQuiz() {
        let questionCount = quizManager?.getAllQuestions().count ?? 0
        takeQuizBtnOutlet.isEnabled =  questionCount > 0
        warningLabel.isHidden = questionCount > 0
    }


}

