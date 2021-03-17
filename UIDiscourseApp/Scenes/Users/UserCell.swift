//
//  UsersCell.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

class UserCell: UICollectionViewCell {
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            labelUsername.text = viewModel.textLabelText
            if let dataImage = viewModel.userDataImage {
                userImage.image = UIImage(data: dataImage)
                userImage.layer.opacity = 1
            } else {
                userImage.layer.opacity = 0
            }
        }
    }
    
    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.masksToBounds = false
        userImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userImage.frame.size = CGSize(width: 80, height: 80)
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        userImage.layer.opacity = 0
        return userImage
    }()
    
    lazy var labelUsername: UILabel = {
        let labelUsername = UILabel()
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.font = .textStyle
        labelUsername.numberOfLines = 2
        labelUsername.textAlignment = .center
        return labelUsername
    }()
    
    lazy var userView: UIView = {
        let userView = UIView()
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.widthAnchor.constraint(equalToConstant: 94).isActive = true
        userView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        userView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.leftAnchor.constraint(equalTo: userView.leftAnchor, constant: 7),
            userImage.topAnchor.constraint(equalTo: userView.topAnchor),
            userImage.rightAnchor.constraint(equalTo: userView.rightAnchor, constant: -7)
        ])
        userView.addSubview(labelUsername)
        NSLayoutConstraint.activate([
            labelUsername.leftAnchor.constraint(equalTo: userView.leftAnchor),
            labelUsername.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 9),
            labelUsername.rightAnchor.constraint(equalTo: userView.rightAnchor)
        ])
        return userView
    }()
    
    var propertyAnimator: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(userView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        propertyAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) { [weak self] in
            guard let self = self else { return }
            guard let dataImage = self.viewModel?.userDataImage else {return}
            self.userImage.image = UIImage(data: dataImage)
            self.userImage.layer.opacity = 1
        }
        propertyAnimator?.startAnimation()
        setNeedsLayout()
    }
}
