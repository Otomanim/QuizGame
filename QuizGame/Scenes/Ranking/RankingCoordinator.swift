//
//  RankingCoordinator.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class RankingCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RankingViewModel(coordinator: self)
        let rankingViewController = RankingViewController()
        navigationController.pushViewController(rankingViewController, animated: true)
    }
}
