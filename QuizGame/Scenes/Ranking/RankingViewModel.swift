//
//  RankingViewModel.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

class RankingViewModel {
    weak var coordinator: RankingCoordinator?
    var users: [User] = []
    
    init(coordinator: RankingCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func fetchRanking() {
        users = CoreDataManager.shared.fetchAllUsersSortedByScore()
    }
}
