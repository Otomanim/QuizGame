//
//  QuizViewModel.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import Foundation

protocol QuizViewModelDelegate: AnyObject {
    func didFetchQuestion(_ question: Question)
    func didSubmitAnswer(isCorrect: Bool, score: Int)
    func didEndQuiz(finalScore: Int)
    func showError(_ error: String)
}

class QuizViewModel {
    weak var coordinator: QuizCoordinator?
    weak var delegate: QuizViewModelDelegate?
    private let user: User
    private var currentQuestion: Question?
    private var score = 0
    private var questionCount = 0
    private let totalQuestions = 10
    
    init(coordinator: QuizCoordinator, user: User) {
        self.user = user
    }
    
    func fetchQuestion() {
        questionCount += 1
        QuizService.shared.fetchQuestion { [weak self] question in
            guard let self = self else { return }
            
            if let question = question {
                self.currentQuestion = question
                self.delegate?.didFetchQuestion(question)
            } else {
                self.delegate?.showError("Erro ao carregar a pergunta.")
            }
        }
    }
    
    func submitAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        
        QuizService.shared.submitAnswer(for: question.id, answer: answer) { [weak self] result in
            guard let self = self else { return }
            
            if result {
                self.score += 10
            }
            
            self.delegate?.didSubmitAnswer(isCorrect: result, score: self.score)
            
            if self.questionCount == self.totalQuestions {
                self.endQuiz()
            } else {
                self.fetchQuestion()
            }
        }
    }
    
    private func endQuiz() {
        user.score = score
        coordinator?.showFinalScore(score: score)
    }
}
