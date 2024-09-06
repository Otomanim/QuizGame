//
//  StringExtension.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

extension String {
    public var lang: String {
        return NSLocalizedString(self, comment: "")
    }
}
