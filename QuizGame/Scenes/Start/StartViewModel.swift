//
//  StartViewModel.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

protocol StartViewModelDelegate: AnyObject {
    func showContinueAlert(for user: User)
}

class StartViewModel {
    weak var delegate: StartViewModelDelegate?
    var coordinator: StartCoordinator
    private var users: [User] = []

    init(coordinator: StartCoordinator) {
        self.coordinator = coordinator
    }
    
    func startQuiz(with name: String) {
        if let existingUser = fetchUser(with: name) {
            delegate?.showContinueAlert(for: existingUser)
        } else {
            let newUser = User(name: name, score: 0)
            users.append(newUser)
            saveUser(newUser)
            coordinator.goToQuiz(user: newUser)
        }
    }
    
    func fetchUser(with name: String) -> User? {
        return CoreDataManager.shared.fetchUserByName(name: name)
    }
    
    private func saveUser(_ user: User) {
            CoreDataManager.shared.saveUser(name: user.name, score: user.score)
        }
    
    func shouldShowRanking() -> Bool {
        return !users.isEmpty
    }
    
    func showRanking() {
        let sortedUsers = users.sorted { $0.score > $1.score }
        coordinator.goToRanking(users: sortedUsers)
    }
}
