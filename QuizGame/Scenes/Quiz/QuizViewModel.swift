//
//  QuizViewModel.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

protocol QuizViewModelDelegate: AnyObject {
    func fetchQuestion(_ question: Question)
    func sumitAnswer()
    func didEndQuiz()
    func showError()
}

class QuizViewModel {
    weak var coordinator: QuizCoordinator?
    private let user: User
    private var currentQuestion: Question?
    private var score = 0
    private var questionCount = 0
    
    init(coordinator: QuizCoordinator, user: User) {
        self.coordinator = coordinator
        self.user = user
    }
    
    func fetchQuestion() {
        questionCount += 1
        QuizService.shared.fetchQuestion { [weak self] question in
            self?.currentQuestion = question
            self?.updateUI(with: question)
        }
    }
    
    func submitAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        
        QuizService.shared.submitAnswer(for: question.id, answer: answer) { [weak self] result in
            if result {
                self?.score += 10
            }
            if self?.questionCount == 10 {
                self?.endQuiz()
            } else {
                self?.fetchQuestion()
            }
        }
    }
    
    private func endQuiz() {
        user.score = score
        coordinator?.showFinalScore(score: score)
    }
}
