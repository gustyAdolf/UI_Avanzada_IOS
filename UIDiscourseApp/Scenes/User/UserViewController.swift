//
//  UserViewController.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

class UserViewController: UIViewController {
    let viewModel: UserViewModel

    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.masksToBounds = false
        userImage.widthAnchor.constraint(equalToConstant: 185).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 185).isActive = true
        userImage.frame.size = CGSize(width: 185, height: 185)
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(data: viewModel.userImageData)
        return userImage
    }()
    
    lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = .textStyle9
        return usernameLabel
    }()
    
    
   

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureConstraints()
    
    }

    private func configureConstraints() {
        let orangeView = UIView(frame: .zero)
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.backgroundColor = .tangerine
        
        view.addSubview(orangeView)
        NSLayoutConstraint.activate([
            orangeView.heightAnchor.constraint(equalToConstant: 150),
            orangeView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        let blackView = UIView(frame: .zero)
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = .black
        
        view.addSubview(blackView)
        NSLayoutConstraint.activate([
            blackView.heightAnchor.constraint(equalToConstant: 245),
            blackView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
            blackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(userImage)
        let topSpacing = 150 - (userImage.frame.height/2)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: topSpacing),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    fileprivate func updateUI() {
       
    }

    fileprivate func showErrorFetchingUser() {
        showAlert("Error fetching user\nPlease try again later")
    }

    fileprivate func showSuccessUpdatingUserName() {
        showAlert("The user name has been successfully updated!", "Success!", "OK")
    }

    fileprivate func showErrorUpdatingUserName() {
        showAlert("Error updating user name\nPlease try again later")
    }

    @objc func updateNameButtonTapped() {
       
    }
}

extension UserViewController: UserViewModelViewDelegate {
    func errorFetchingUser() {
        showErrorFetchingUser()
    }

    func userDataFetched() {
        updateUI()
    }

    func successUpdatingUserName() {
        showSuccessUpdatingUserName()
    }

    func errorUpdatingUserName() {
        showErrorUpdatingUserName()
    }
}
