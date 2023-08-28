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
        
        if quizManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Quiz Game")
                    .customTitle()
                Text("Congratulations, you completed the quiz!")
                    .customProfileText()
                
                Text("Your score is: \(quizManager.score) out of \(quizManager.length)")
                    .customInfoText()
            }
            .navigationBarBackButtonHidden(true)
            .foregroundColor(Color.darkPurple)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.dustyGray)
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
