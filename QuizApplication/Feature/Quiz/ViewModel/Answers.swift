//
//  Answers.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import Foundation

struct Answers: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
