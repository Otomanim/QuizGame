//
//  StartCoordinator.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class StartCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var user: User?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = StartViewModel(coordinator: self)
        let startViewController: StartViewController = StartViewController(viewModel: viewModel)
        navigationController.pushViewController(startViewController, animated: true)
    }
    
    func goToQuiz(user: User) {
        self.user = user
        let quizCoordinator = QuizCoordinator(navigationController: navigationController, user: user)
        quizCoordinator.start()
    }
    
    func goToRanking() {
//        let rankingCoodinator
    }
}

