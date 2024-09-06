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
    var coordinator: QuizCoordinator
    weak var delegate: (QuizViewModelDelegate)?
    private let user: User
    private var currentQuestion: Question?
    private var score = 0
    var questionCount = 0
    let totalQuestions = 10
    
    init(coordinator: QuizCoordinator, user: User) {
        self.coordinator = coordinator
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
                self.delegate?.showError("Error loading the question.".lang)
            }
        }
    }
    
    func submitAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        
        QuizService.shared.submitAnswer(for: question.id, answer: answer) { [weak self] isCorrect in
            guard let self = self else { return }
            
            if isCorrect {
                self.score += 10
            }
            
            self.delegate?.didSubmitAnswer(isCorrect: isCorrect, score: self.score)
            self.checkQuizFinished()
        }
    }
    
    func checkQuizFinished() {
        if questionCount == totalQuestions {
            endQuiz()
        }
    }
    
    func restartQuiz() {
        questionCount = 0
        score = 0
        fetchQuestion()
    }
    
    private func endQuiz() {
        CoreDataManager.shared.saveUser(name: user.name, score: score)
        delegate?.didEndQuiz(finalScore: score)
    }
}
