//
//  FinalScoreView.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 06/09/24.
//

import SwiftUI

struct FinalScoreView: View {
    let score: Int
    let retryAction: () -> Void
    let exitAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sua pontuação: \(score)")
                .font(.system(size: 24))
                .padding()
            
            Button(action: retryAction) {
                Text("Try Again".lang)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: exitAction) {
                Text("To go out".lang)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct FinalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FinalScoreView(score: 0, retryAction: {}, exitAction: {})
    }
}
