//
//  ProgressComponentView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import SwiftUI

struct ProgressComponentView: View {
    var progressBar: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 3)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            Rectangle()
                .frame(width: progressBar, height: 3)
                .foregroundColor(Color.darkPurple)
                .cornerRadius(10)
        }
    }
}

struct ProgressComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressComponentView(progressBar: 10)
    }
}
