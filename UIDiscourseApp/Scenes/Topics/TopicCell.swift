//
//  TopicsCell.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import UIKit

class TopicCell: UITableViewCell {
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            labelTopicTitle.text = viewModel.topicTitle
            labelPostCount.text = viewModel.postsCount
            labelNumberOfPosters.text = viewModel.numberOfPosters
            labelLastPostedAt.text = viewModel.lastPostedAt.formatedStringDate(toFormat: "MMM dd")
            if let dataImage = viewModel.userDataImage {
                userImage.image = UIImage(data: dataImage)
            } else {
                userImage.image = UIImage(named: "ico_user")
            }
        }
    }
    
   
    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.masksToBounds = false
        userImage.frame.size = CGSize(width: 64, height: 64)
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        return userImage
    }()
    
    lazy var labelTopicTitle: UILabel = {
        let labelTopicTitle = UILabel()
        labelTopicTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicTitle.font = .textStyle5
        labelTopicTitle.numberOfLines = 2
        return labelTopicTitle
    }()
        
    lazy var labelPostCount: UILabel = {
        let labelPostCount = UILabel()
        labelPostCount.translatesAutoresizingMaskIntoConstraints = false
        labelPostCount.font = .textStyle7
        return labelPostCount
    }()
    
    lazy var labelNumberOfPosters: UILabel = {
        let labelNumberOfPosters = UILabel()
        labelNumberOfPosters.translatesAutoresizingMaskIntoConstraints = false
        labelNumberOfPosters.font = .textStyle7
        return labelNumberOfPosters
    }()
    
    lazy var labelLastPostedAt: UILabel = {
        let labelLastPostedAt = UILabel()
        labelLastPostedAt.translatesAutoresizingMaskIntoConstraints = false
        labelLastPostedAt.font = .textStyle2
        return labelLastPostedAt
    }()
    
    
    
    lazy var topicDataStack: UIStackView = {
        let topicDataStack = UIStackView()
        topicDataStack.translatesAutoresizingMaskIntoConstraints = false
        topicDataStack.axis = .horizontal
        topicDataStack.spacing = 6
        topicDataStack.layer.opacity = 0.5
        return topicDataStack
    }()
    
    lazy var topicStack: UIStackView = {
        let topicStack = UIStackView(arrangedSubviews: [labelTopicTitle, topicDataStack])
        topicStack.translatesAutoresizingMaskIntoConstraints = false
        topicStack.axis = .vertical
        topicStack.spacing = 4
        topicStack.alignment = .leading
        return topicStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: 64),
            userImage.widthAnchor.constraint(equalToConstant: 64),
            userImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        let commentStack = createIconWithLabelHorizontalStack(iconName: "ico_comment", label: labelPostCount)
        let usersStack = createIconWithLabelHorizontalStack(iconName: "ico_user", label: labelNumberOfPosters)
        let calendarStack = createIconWithLabelHorizontalStack(iconName: "ico_calendar", label: labelLastPostedAt)
        topicDataStack.addArrangedSubview(commentStack)
        topicDataStack.addArrangedSubview(usersStack)
        topicDataStack.addArrangedSubview(calendarStack)
        
        contentView.addSubview(topicStack)
        NSLayoutConstraint.activate([
            topicStack.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 11),
            topicStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            topicStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -59),
            topicStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createIconWithLabelHorizontalStack(iconName: String, label: UILabel) -> UIStackView {
        let icon = UIImageView(image: UIImage(named: iconName))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        let stack = UIStackView(arrangedSubviews: [icon, label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }
}

extension TopicCell: TopicCellViewModelDelegate {
    func userImageFetched() {
        guard let dataImage = viewModel?.userDataImage else {return}
        userImage.image = UIImage(data: dataImage)
        setNeedsLayout()
    }
    
    
}
