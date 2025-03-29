//
//  Models.swift
//  assignment-3-quiz-app
//
//  Created by James Chard on 2025/3/28.
//

import Foundation

class Quiz {
    var questions: [Question] = []
    var userAnswers: [UUID: UserAnswer] = [:]
    var completedQuestions = 0
    var correctQuestions = 0
    var score = 0.0
    
    func addQuestion(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {

        let q = Question(questionText: questionText, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
        
        questions.append(q)
    }
    
    func updateQuestion (questionID: UUID, questionText: String, correctAnswer: String, incorrectAnswers: [String]) -> Bool {
        
        if let index = questions.firstIndex(where: {q in q.questionID == questionID}) {
            questions[index].questionText = questionText
            questions[index].correctAnswer = correctAnswer
            questions[index].incorrectAnswers = incorrectAnswers
            
            return true;
        }
        return false;
    }
    
    func getRandomizedAnswers(questionID: UUID) -> [String] {
        
        if let question = questions.first(where: {q in q.questionID == questionID}) {
            let ans = [question.correctAnswer, question.incorrectAnswers[0], question.incorrectAnswers[1], question.incorrectAnswers[2]]
            
            return ans.shuffled()
                
        }
        
        return []
    }
    
    func recordAnswer(answerText: String, questionID: UUID) {
        if let question = questions.first(where: {q in q.questionID == questionID}) {
            let isCorrect = answerText == question.correctAnswer
            userAnswers[questionID]  = UserAnswer(answerText: answerText, isCorrect: isCorrect)
        }
    }
    
    
    func calcFinalScore() -> Double {
        score = Double(correctQuestions) / Double(completedQuestions)
        return score
    }
    
    func getFinalPercentScore() -> String {
        return "\(score * 100)%"
    }
    
    func hasQuestion(questionText: String) -> Bool {
        for q in questions {
            if(q.questionText == questionText) { return true }
        }
        
        return false;
        
    }
}

class UserAnswer {
    let isCorrect: Bool
    let answerText: String
    
    init(answerText: String, isCorrect: Bool) {
        self.answerText = answerText
        self.isCorrect = isCorrect
    }
}


class Question {
    let questionID: UUID
    var questionText: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    init(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
        self.questionText = questionText
        self.questionID = UUID()
    }
}
