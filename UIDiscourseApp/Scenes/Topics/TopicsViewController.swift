//
//  TopicsViewController.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import UIKit

class TopicsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(WelcomeCell.self, forCellReuseIdentifier: "WelcomeCell")
        table.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var floatingButton: UIButton = {
        let floatingButton = UIButton()
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        floatingButton.frame.size =  CGSize(width: 64, height: 64)
        floatingButton.layer.cornerRadius = floatingButton.frame.height/2
        floatingButton.setImage(UIImage(named: "ico_floating_add"), for: .normal)
        floatingButton.backgroundColor = .tangerine
        floatingButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return floatingButton
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    let viewModel: TopicsViewModel
    
    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        title = "Temas"
        tableView.refreshControl = refreshControl
        configureConstraints()
        configureNavigationBar()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    private func configureNavigationBar() {
        let addBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ico_add"), style: .plain, target: self, action: #selector(plusButtonTapped))
        let searchBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ico_search"), style: .plain , target: self, action: nil)
        navigationItem.leftBarButtonItem = addBarButtonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
        tabBarItem.badgeColor = .blue
        
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.prefersLargeTitles = true
        navBar.tintColor = .tangerine
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .brownGrey
        borderView.layer.opacity = 0.3
        
        navBar.backgroundColor = .white82
        navBar.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
            borderView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor)
        ])
    }
    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    @objc func refreshControlPulled() {
        viewModel.viewWasLoaded()
        refreshControl.endRefreshing()
    }
    
    private func configureConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(floatingButton)
        NSLayoutConstraint.activate([
            floatingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    
}


extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let topicCellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel,
           let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell {
            cell.viewModel = topicCellViewModel
            return cell
        } else if let welcomeCellViewModel = viewModel.viewModel(at: indexPath) as? WelcomeCellViewModel,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeCell", for: indexPath) as? WelcomeCell {
            cell.viewModel = welcomeCellViewModel
            return cell
        }
        fatalError()
    }
}
extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
    }
    
    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}
