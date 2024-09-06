//
//  StartViewModel.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

protocol StartViewModelCoordinatorDelegate: AnyObject {
    func startQuiz(with user: User)
    func showRanking()
}

class StartViewModel {
    var coordinator: StartCoordinator
    private var users: [User] = []

    init(coordinator: StartCoordinator) {
        self.coordinator = coordinator
    }
    
    func startQuiz(with name: String) {
        if let existingUser = users.first(where: { $0.name == name }) {
            coordinator.goToQuiz(user: existingUser)
        } else {
            let newUser = User(name: name, score: 0)
            users.append(newUser)
            coordinator.goToQuiz(user: newUser)
        }
    }
    
    func shouldShowRanking() -> Bool {
        return !users.isEmpty
    }
    
    func showRanking() {
//        coordinator?.goToRanking(users: users.sorted { $0.score > $0.score })
    }
}
