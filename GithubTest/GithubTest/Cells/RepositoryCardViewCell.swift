//
//  RepositoryCardViewCell.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/30/23.
//

import UIKit
import Combine
import Kingfisher

class RepositoryCardViewCell: UICollectionViewCell {
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .white
        }
    }
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.backgroundColor = .gray2e3a5a
            cardView.layer.cornerRadius = 15.0
        }
    }
    
    func configure(with model: Repository) {
        setupContent(model)
        setupImage(model)
    }
    
    private func setupImage(_ repository: Repository) {
        KF.url(repository.owner.avatarUrl)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: imageContainer)
    }
    
    private func setupContent(_ repository: Repository) {
        nameLabel.attributedText = repository.fullName.toCardTitle()
        ownerLabel.attributedText = repository.owner.login.toCardStandard()
        starsLabel.attributedText = "\(repository.stargazersCount) ⭐️".toCardStandard()
        languageLabel.attributedText = repository.language?.toCardStandard(textAlignment: .right)
        descriptionLabel.attributedText = repository.description?.toCardStandard()
    }
}
