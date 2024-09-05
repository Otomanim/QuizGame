//
//  QuizCoordinator.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class QuizCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var user: User
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let viewModel = QuizViewModel(coordinator: self, user: user)
        let quizViewController = QuizViewController(viewModel: viewModel)
        navigationController.pushViewController(quizViewController, animated: true)
    }
    
    func showFinalScore(score: Int) {
    }
    
    func backToStart() {
        navigationController.popToRootViewController(animated: true)
    }
}
