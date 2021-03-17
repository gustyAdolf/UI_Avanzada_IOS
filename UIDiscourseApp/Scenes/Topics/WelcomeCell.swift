//
//  WelcomeTableViewCell.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 12/3/21.
//

import UIKit

class WelcomeCell: UITableViewCell {
    
    var viewModel: WelcomeCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            labelTitle.text = viewModel.labelTitle
            labelSubTitle.text = viewModel.labelSubTitle
        }
    }
    
    lazy var labelTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .textStyle4
        return title
    }()
    
    lazy var labelSubTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.font = .textStyle8
        subTitle.numberOfLines = 2
        return subTitle
    }()
    
    
    lazy var contentStack: UIStackView = {
        let contentStack = UIStackView(arrangedSubviews: [labelTitle, labelSubTitle])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 6
        return contentStack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 150),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        let orangeView = UIView()
        orangeView.backgroundColor = .tangerine
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.layer.cornerRadius = 8
        contentView.addSubview(orangeView)
        NSLayoutConstraint.activate([
            orangeView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            orangeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            orangeView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            orangeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
        
        let pushPin = UIImageView(image: UIImage(named: "ico_pushpin"))
        pushPin.translatesAutoresizingMaskIntoConstraints = false
        orangeView.addSubview(pushPin)
        NSLayoutConstraint.activate([
            pushPin.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: 11),
            pushPin.rightAnchor.constraint(equalTo: orangeView.rightAnchor, constant: -15)
        ])
        
        orangeView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leftAnchor.constraint(equalTo: orangeView.leftAnchor, constant: 18),
            contentStack.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: 9),
            contentStack.rightAnchor.constraint(equalTo: orangeView.rightAnchor, constant: -73),
        ])
        
        
      
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
