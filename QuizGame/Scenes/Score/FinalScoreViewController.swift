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
    private  let scoreLabel = UILabel()
    
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
        
        scoreLabel.text = "Your_score \(score)".lang
        scoreLabel.font = .systemFont(ofSize: 24)
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Try Again".lang, for: .normal)
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        view.addSubview(retryButton)
        
        let exitButton = UIButton(type: .system)
        exitButton.setTitle("To go out".lang, for: .normal)
        exitButton.addTarget(self, action: #selector(exitQuiz), for: .touchUpInside)
        view.addSubview(exitButton)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.topAnchor.constraint(equalTo: retryButton.bottomAnchor, constant: 20),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func retry() {
        coordinator.start()
    }
    
    @objc private func exitQuiz() {
        coordinator.backToStart()
    }
}
