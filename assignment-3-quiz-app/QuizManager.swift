//
//  QuizManager.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import Foundation

protocol QuizDelegate {
    func didAddQuestion(questions: [Question])
}

protocol QuizBuilderDelegate {
    func addQuestionDidFail(reason: String)
}

protocol QuizTakerDelegate {
    func didSelectAnswer()
}

protocol QuizResultDelegate {
    func didFinishQuiz()
}

class QuizManager {
    
    static var shared = QuizManager()
    var quiz: Quiz = Quiz()
    var quizManagerDelegate: QuizDelegate?
    var quizBuilderDelegate: QuizBuilderDelegate?
    var quizTakerDelegate: QuizTakerDelegate?
    
//  for development or testing, add test questions
    private init() {
//        createSampleQuestions()
    }
    
    func addQuestion(questionText: String, correctAnswer: String, incorrectAnswers: [String]) -> Bool {
        
        if(quiz.hasQuestion(questionText: questionText)) {
            self.quizBuilderDelegate?.addQuestionDidFail(reason: "The question already exists")
            return false
        }

        quiz.addQuestion(questionText: questionText, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
        
        self.quizManagerDelegate?.didAddQuestion(questions: getAllQuestions())
        return true
    }
    
    func updateQuestion(questionID: UUID, questionText: String, correctAnswer: String, incorrectAnswers: [String]) -> Bool {

        let result = quiz.updateQuestion(questionID: questionID, questionText: questionText, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
        
        if(result) {
            self.quizManagerDelegate?.didAddQuestion(questions: getAllQuestions())
        } else {
            self.quizBuilderDelegate?.addQuestionDidFail(reason: "Failed to update question")
        }
        
        return result
    }
    
    func getAllQuestions()-> [Question] {
        return quiz.questions
    }
    
    func printUserAnswers() {
        print("current user answers (count: \(quiz.userAnswers.count): ")
        for (id, ans) in quiz.userAnswers {
            print("id: \(id), answer: \(ans.answerText), isCorrect: \(ans.isCorrect)")
            
        }
        print("------------------------")
    }
    
    func getQuizResultText() -> String {
        let questionCount = getAllQuestions().count
        var correctAnswerCount = 0;
        
        for (_, ans) in quiz.userAnswers {
            if(ans.isCorrect) {
                correctAnswerCount += 1;
            }
        }
        
        let percentCorrect = Double(correctAnswerCount) / Double(questionCount) * 100
        let formattedPercent = String(format: "%.1f%%", percentCorrect)
        return "\(correctAnswerCount)/\(questionCount) (\(formattedPercent))"
        
    }

    func resetUserAswers() {
        quiz.userAnswers = [:]
    }
    
    func createSampleQuestions() {

        quiz.questions.append(Question(
            questionText: "What is 5 + 3?",
            correctAnswer: "8",
            incorrectAnswers: ["7", "9", "6"]
        ))
        
        quiz.questions.append(Question(
            questionText: "What is 10 - 4?",
            correctAnswer: "6",
            incorrectAnswers: ["5", "7", "4"]
        ))
        

        quiz.questions.append(Question(
            questionText: "What is 3 × 4?",
            correctAnswer: "12",
            incorrectAnswers: ["10", "11", "16"]
        ))
        
        
        quiz.questions.append(Question(
            questionText: "What is 8 ÷ 2?",
            correctAnswer: "4",
            incorrectAnswers: ["3", "5", "2"]
        ))
        
        
        quiz.questions.append(Question(
            questionText: "What is 6 + 2 × 2?",
            correctAnswer: "10",
            incorrectAnswers: ["16", "8", "12"]
        ))
        
    }
    
}
