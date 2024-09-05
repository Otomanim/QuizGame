//
//  Endpoints.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

struct Endpoints {
    static let baseURL = "https://quiz-api-bwi5hjqyaq-uc.a.run.app"
    
    static var fetchQuestion: String {
        return "\(baseURL)/question"
    }
    
    static func submitAnswer(questionId: String) -> String {
        return "\(baseURL)/answer?questionId=\(questionId)"
    }
}
