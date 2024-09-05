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
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc private func submitAnswer() {
        guard let selectedOption = selectedOption else {
            showAlert(message: "Por favor, selecione uma resposta.")
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
        <#code#>
    }
    
    func didEndQuiz(finalScore: Int) {
        <#code#>
    }
    
    func showError(_ error: String) {
        <#code#>
    }
    
    
}
