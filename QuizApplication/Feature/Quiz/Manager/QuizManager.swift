//
//  QuizManager.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import Foundation
import SwiftUI

class QuizManager: ObservableObject {
    private(set) var quiz: [QuizModel.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var end = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answers] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    
    init() {
        Task.init {
            await fetchData()
        }
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=15&category=18&difficulty=easy") else { fatalError("URL is missing")}
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error when I tried to fetch data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(QuizModel.self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.end = false
                
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    func nextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            end = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currentQuestion = quiz[index]
            question = currentQuestion.formattedQuestion
            answerChoices = currentQuestion.answers
        }
    }
    
    func chooseAnswer(answer: Answers) {
        answerSelected = true
        if answer.isCorrect {
            score += 1 
            
        }
    }
}
