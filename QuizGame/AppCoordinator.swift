//
//  AppCoordinator.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startCoodinator = StartCoordinator(navigationController: navigationController)
        startCoodinator.start()
    }
    
    
}
