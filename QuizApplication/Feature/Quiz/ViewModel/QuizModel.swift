//
//  QuizModel.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import Foundation

struct QuizModel: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        }
        var category: String
        var type: String
        var difficulty: String
        var question: String
        var correctAnswer: String
        var incorrectAnswer: [String]
        
        var formattedString: AttributedString {
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Formatted Error: \(error)")
                return ""
            }
        }
        
        var answers: [Answers] {
            do {
                let isCorrect = [Answers(quizText: try AttributedString(markdown: correctAnswer), answer: true)]
                let isIncorrect = try incorrectAnswer.map { answers in
                    Answers(quizText: try AttributedString(markdown: answers), answer: false)
                }
                let allAnswers = isCorrect + isIncorrect
                return allAnswers.shuffled()
            } catch {
                print("Answer Error: \(error)")
                return []
            }
        }
    }
}
