//
//  AnswersRowView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import SwiftUI

struct AnswersRowView: View {
    @EnvironmentObject var quizManager: QuizManager
    @State private var selected = false
    var answers: Answers
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.dashed")
                .font(.body)
            
            Text(answers.text)
                .bold()
            
            if selected == true {
                Spacer()
                Image(systemName: answers.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(answers.isCorrect ? .green : .red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .foregroundColor(quizManager.answerSelected ? (selected ? Color.darkPurple : .gray) : Color.darkPurple)
        .cornerRadius(10)
        .shadow(color: selected ? (answers.isCorrect ? .green : .red) : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !quizManager.answerSelected {
                selected = true
                quizManager.chooseAnswer(answer: answers)
            }
        }
    }
}

struct AnswersRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnswersRowView(answers: Answers(text: "First", isCorrect: false))
            .environmentObject(QuizManager())
    }
}
