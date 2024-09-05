//
//  Coordinator.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()
}
