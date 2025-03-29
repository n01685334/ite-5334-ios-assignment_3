//
//  QuizResultViewController.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import UIKit

class QuizResultViewController: UIViewController {
    
    var delegate: QuizResultDelegate?
    

    var quizResult: String?
    
    @IBAction func resetBtnAction(_ sender: Any) {
        delegate?.didFinishQuiz()
        dismiss(animated: true)
    }
    
    @IBOutlet weak var resultText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultText.text = quizResult ?? "Unknown"
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
