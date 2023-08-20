//
//  QuizView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        if quizManager.end {
            VStack(spacing: 20) {
                Text("Quiz Game")
                    .foregroundColor(Color.darkPurple)
                    .font(.system(size: 30, weight: .bold))
                Text("Congratulations, you completed the game!")
                    .foregroundColor(Color.darkPurple)
                    .font(.system(size: 15, weight: .bold))
                
                Text("Your score is: \(quizManager.score) out of \(quizManager.length)")
                
                Button {
                    Task.init {
                        await quizManager.fetchData()
                    }
                } label: {
                    QuizButtonView(text: "Go to Profile")
                }
            }
        } else {
            QuestionView()
                .environmentObject(quizManager)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizManager())
    }
}
