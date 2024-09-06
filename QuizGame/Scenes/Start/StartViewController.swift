//
//  StartViewController.swift
//  FunQuiz
//
//  Created by Evandro Rodrigo Minamoto on 04/09/24.
//

import UIKit

class StartViewController: UIViewController {
    
    private let viewModel: StartViewModel
    private let nameTextField = UITextField()
    private let startButton = UIButton(type: .system)
    private let rankingButton = UIButton(type: .system)
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        nameTextField.placeholder = "Enter your name".lang
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        
        startButton.setTitle("Start Quiz".lang, for: .normal)
        startButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        view.addSubview(startButton)
        
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.addTarget(self, action: #selector(showRanking), for: .touchUpInside)
//        rankingButton.isHidden = !viewModel.shouldShowRanking()
        view.addSubview(rankingButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rankingButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            rankingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func startQuiz() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter a name.".lang)
            return
        }
        viewModel.startQuiz(with: name)
    }
    
    @objc private func showRanking() {
        viewModel.showRanking()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
