//
//  QuizService.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

class QuizService {
    
    static let shared = QuizService()
    private init() {}
    
    func fetchQuestion(completion: @escaping (Question?) -> Void) {
        Service.shared.getRequest(urlString: Endpoints.fetchQuestion, completion: completion)
    }
    
    func submitAnswer(for questionId: String, answer: String, completion: @escaping (Bool) -> Void) {
        let urlString = Endpoints.submitAnswer(questionId: questionId)
        
        let body: [String: String] = ["answer": answer]
        Service.shared.postRequest(urlString: urlString, body: body) { (response: AnswerResponse?) in
            completion(response?.result ?? false)
        }
    }
}
