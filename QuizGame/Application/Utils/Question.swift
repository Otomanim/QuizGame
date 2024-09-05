//
//  Question.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

struct Question: Decodable {
    let id: String
    let statement: String
    let options: [String]
}
