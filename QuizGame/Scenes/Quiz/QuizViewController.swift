//
//  QuizViewController.swift
//  FunQuiz
//
//  Created by Evandro Rodrigo Minamoto on 04/09/24.
//

import SwiftUI
import UIKit

class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModel
    private let questionLabel = UILabel()
    private let optionsStackView = UIStackView()
    private var selectedOption: String?
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.delegate = self
        setupUI()
        viewModel.fetchQuestion()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.8)
        
        questionLabel.font = .systemFont(ofSize: 18)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        view.addSubview(questionLabel)
        
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        view.addSubview(optionsStackView)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Send reply".lang, for: .normal)
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.white.cgColor
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        submitButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        submitButton.addTarget(self, action: #selector(submitAnswer), for: .touchUpInside)
        view.addSubview(submitButton)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 300),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc private func submitAnswer() {
        guard let selectedOption = selectedOption else {
            showAlert(message: "Please select an answer.".lang)
            return
        }
        viewModel.submitAnswer(selectedOption)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func updateUI(with question: Question) {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        question.options.forEach { option in
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.lineBreakMode = .byCharWrapping
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.contentHorizontalAlignment = .center
            button.backgroundColor = UIColor.opaqueSeparator.withAlphaComponent(0.5)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 8.0
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setContentHuggingPriority(.defaultLow, for: .vertical)
            button.setContentCompressionResistancePriority(.required, for: .vertical)
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
            let heightConstraint = button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
            let characterCount = option.count
            if characterCount > 50 && characterCount <= 80{
                heightConstraint.constant = 60
            }
            if characterCount > 80 {
                heightConstraint.constant = 100
            }
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
                heightConstraint,
            ])
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        selectedOption = title
        
        optionsStackView.arrangedSubviews.forEach {
            $0.backgroundColor = .clear
        }
        sender.backgroundColor = .lightGray
    }
}

extension QuizViewController: QuizViewModelDelegate {
    func didFetchQuestion(_ question: Question) {
        questionLabel.text = question.statement
        DispatchQueue.main.async {
            self.updateUI(with: question)
        }
        
    }
    
    func didSubmitAnswer(isCorrect: Bool, score: Int) {
        let message = isCorrect ? "Correct answer".lang : "Wrong answer".lang
        let alert = UIAlertController(title: "Result".lang, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if self.viewModel.questionCount < self.viewModel.totalQuestions {
                self.viewModel.fetchQuestion()
            } else {
                self.viewModel.checkQuizFinished()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func didEndQuiz(finalScore: Int) {
        
        let finalScoreView = FinalScoreView(
            score: finalScore,
            retryAction: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
                self?.viewModel.restartQuiz()
            },
            exitAction: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
                self?.viewModel.coordinator.backToStart()
            }
        )
        
        let hostingController = UIHostingController(rootView: finalScoreView)
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error".lang, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
