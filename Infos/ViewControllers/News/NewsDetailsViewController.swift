//
//  NewsDetailsViewController.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import UIKit

class NewsDetailsViewController: BaseViewController {
    
    enum Constants {
        static let title: String = "Детали"
    }
    
    // MARK: UI elements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.color = .systemBlue
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var viewModel: NewsDetailsViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.indicator.stopAnimating()
                }
            }
            viewModel?.setUpdateIndicatorHandler { [weak self] isLoading in
                DispatchQueue.main.async { [weak self] in
                    isLoading ? self?.indicator.startAnimating() : self?.indicator.stopAnimating()
                }
            }
            viewModel?.setErrorHandler({ [weak self] text in
                DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                    self?.showErrorAlert(text: text)
                }
            })
        }
    }
}

// MARK: Life cycle
extension NewsDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refresh()
    }
}

// MARK: - UITableViewDataSource
extension NewsDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfElements(in: section) ?? .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { fatalError("ViewModel not init") }
        
        let element = viewModel.getElement(at: indexPath.row, section: indexPath.section)
        
        switch element {
        case .image(let text):
            return UITableViewCell()
        case .title(let text):
            return UITableViewCell()
        case .description(let text):
            return UITableViewCell()
        case .content(let text):
            return UITableViewCell()
        }
    }
}

// MARK: Private
private extension NewsDetailsViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerClass(forCell: UITableViewCell.self)
        
        navigationItem.title = Constants.title
    }
    
    
    func showErrorAlert(text: String) {
        let action = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        showAlert(title: text, message: "", actions: [action])
    }
}
