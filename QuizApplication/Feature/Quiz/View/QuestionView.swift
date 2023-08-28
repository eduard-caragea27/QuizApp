//
//  TestView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("QUIZ")
                    .foregroundColor(Color.darkPurple)
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
                
                Text("\(quizManager.index + 1) from \(quizManager.length)")
                    .foregroundColor(Color.darkPurple)
                    .font(.system(size: 15, weight: .bold))
            }

            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(.system(size: 20, weight: .medium))
                
                ForEach(quizManager.answerChoices, id: \.id) { answers in
                    AnswersRowView(answers: answers)
                        .environmentObject(quizManager)
                    
                }
            }
            
            ProgressComponentView(progressBar: quizManager.progress)
            
            HStack {
                
                Spacer()
                
                Button {
                    quizManager.nextQuestion()
                } label: {
                    QuizButtonView(text: "Next", background: quizManager.answerSelected ? Color.darkPurple : .gray)
                }
                .disabled(!quizManager.answerSelected)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.dustyGray)
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(QuizManager())
    }
}
