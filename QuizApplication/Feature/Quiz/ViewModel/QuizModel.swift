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
            var incorrectAnswers: [String]
            
            var formattedQuestion: AttributedString {
                do {
                    
                    return try AttributedString(markdown: question)
                } catch {
                    
                    print("Error setting formattedQuestion: \(error)")
                    return ""
                }
            }
        
            var answers: [Answers] {
                do {
                    let correct = [Answers(text: try AttributedString(markdown: correctAnswer), isCorrect: true)]
                    let incorrects = try incorrectAnswers.map { answer in
                        Answers(text: try AttributedString(markdown: answer), isCorrect: false)
                    }
                    let allAnswers = correct + incorrects
                    return allAnswers.shuffled()
                } catch {
                    print("Error setting answers: \(error)")
                    return []
                }
            }
        }
}
