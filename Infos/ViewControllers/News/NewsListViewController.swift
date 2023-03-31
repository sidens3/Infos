//
//  NewsListViewController.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import UIKit

class NewsListViewController: BaseViewController {
    
    enum Constants {
        static let title: String = "Новости"
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
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .systemBlue
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        return refreshControl
    }()
    
//    var router: NewsListRouting?
    var viewModel: NewsListViewModeling? {
        didSet {
            viewModel?.setUpdateHandler { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.indicator.stopAnimating()
                    self?.refreshControl.endRefreshing()
                }
            }
            viewModel?.setBasicElementsUpdateHandler { [weak self] index in
                DispatchQueue.main.async {
                    self?.tableView.reloadSections(IndexSet(integer: index), with: .automatic)
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
extension NewsListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refresh()
    }
}

// MARK: - Actions
private extension NewsListViewController {
    
    @objc
    func refresh() {
        viewModel?.refresh()
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { fatalError("ViewModel not init") }
        let element = viewModel.getElement(at: indexPath.row, section: indexPath.section)
        
        switch element {
        case .news:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfElements(in: section) ?? .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { fatalError("ViewModel not init")}
        
        let element = viewModel.getElement(at: indexPath.row, section: indexPath.section)
        
        switch element {
        case .news(let article):
            let cell = tableView.dequeue(NewsTableViewCell.self, for: indexPath)
            cell.configure(for: article)
            return cell
        }
    }
}

// MARK: Private
private extension NewsListViewController {
    
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
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        
        tableView.registerClass(forCell: NewsTableViewCell.self)
        
        navigationItem.title = Constants.title
    }
    
    func showErrorAlert(text: String) {
        let action = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        showAlert(title: text, message: "", actions: [action])
    }
}
