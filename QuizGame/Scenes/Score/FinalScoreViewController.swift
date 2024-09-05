//
//  FinalViewController.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class FinalScoreViewController: UIViewController {
    private let score: Int
    private let coordinator: QuizCoordinator
    
    init(score: Int, coordinator: QuizCoordinator) {
        self.score = score
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        
    }
    
    @objc private func retry() {
        coordinator.start()
    }
    
    @objc private func exitQuiz() {
        coordinator.backToStart()
    }
}
