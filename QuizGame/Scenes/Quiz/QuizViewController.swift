//
//  QuizViewController.swift
//  FunQuiz
//
//  Created by Evandro Rodrigo Minamoto on 04/09/24.
//

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
        
        questionLabel.font = .systemFont(ofSize: 18)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        view.addSubview(questionLabel)
        
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 10
        view.addSubview(optionsStackView)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Send reply".lang, for: .normal)
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
        questionLabel.text = question.statement
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        question.options.forEach { option in
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
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
    }
    
    func didSubmitAnswer(isCorrect: Bool, score: Int) {
        let message = isCorrect ? "Correct answer".lang : "Wrong answer".lang
        let alert = UIAlertController(title: "Result".lang, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.viewModel.fetchQuestion()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func didEndQuiz(finalScore: Int) {
        let alert = UIAlertController(title: "Quiz finished".lang, message: "Your final score is \(finalScore). Do you want to try again?".lang, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again".lang, style: .default, handler: { _ in
            self.viewModel.fetchQuestion()
        }))
        alert.addAction(UIAlertAction(title: "To go back".lang, style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error".lang, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
