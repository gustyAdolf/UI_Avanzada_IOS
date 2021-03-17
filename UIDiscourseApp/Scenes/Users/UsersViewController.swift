//
//  UsersViewController.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

class UsersViewController: UIViewController {
    let viewModel: UsersViewModel
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowLayout.minimumInteritemSpacing = 20.5
        flowLayout.itemSize = CGSize(width: 94, height: 124)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = 18
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        title = "Usuarios"
        collectionView.refreshControl = refreshControl
        configureConstraints()
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingUsers() {
        showAlert("Error fetching users\nPlease try again later")
    }
    
    @objc func refreshControlPulled() {
        viewModel.viewWasLoaded()
        refreshControl.endRefreshing()
    }
    
    private func configureConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let addBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ico_add"), style: .plain, target: self, action: nil)
        let searchBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ico_search"), style: .plain , target: self, action: nil)
        navigationItem.leftBarButtonItem = addBarButtonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
        
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
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userCellViewModel = viewModel.viewModel(at: indexPath),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell
        else {fatalError()}
        cell.viewModel = userCellViewModel
        return cell
    }
    
}

extension UsersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewModelViewDelegate {
    func usersWereFetched() {
        collectionView.reloadData()
    }
    
    func errorFetchingUsers() {
        showErrorFetchingUsers()
    }
}
