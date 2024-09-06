//
//  Ranking.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 05/09/24.
//

import UIKit

class RankingViewController: UIViewController {
    
    private let viewModel: RankingViewModel
    private let tableView = UITableView()
    
    init(viewModel: RankingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchRanking()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.8)
        title = "Ranking"
        
        tableView.backgroundColor = UIColor.cyan.withAlphaComponent(0.1)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = "\(user.name) - \(user.score) pontos"
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

