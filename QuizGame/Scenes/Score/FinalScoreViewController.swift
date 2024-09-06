//
//  FinalViewController.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit
import SwiftUI

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
        
        let finalScoreView = FinalScoreView(
            score: score,
            retryAction: { [weak self] in
                self?.retry()
            },
            exitAction: { [weak self] in
                self?.exitQuiz()
            }
        )
        
        let hostingController = UIHostingController(rootView: finalScoreView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    private func retry() {
        coordinator.start()
    }
    
    private func exitQuiz() {
        coordinator.backToStart()
    }
}
