//
//  EpisodeCollectionCell.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import UIKit

final class EpisodeCollectionCell: UICollectionViewCell {
  static let identifier = "EpisodeCollectionCell"

  private let titleLabel = UILabel()
  private let episodeLabel = UILabel()
  private let episodeUrlLabel = UILabel()
  private let scrollView = UIScrollView()
  private let stackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    contentView.backgroundColor = .systemBackground
    contentView.layer.cornerRadius = 10
    contentView.clipsToBounds = true
    contentView.layer.masksToBounds = true
    contentView.layer.borderWidth = 0.5

    // Title
    titleLabel.font = .boldSystemFont(ofSize: 20)
    titleLabel.numberOfLines = 0
    titleLabel.numberOfLines = 1
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.8

    // Episode code
    episodeLabel.font = .systemFont(ofSize: 12)
    episodeLabel.textColor = .label
    episodeUrlLabel.textColor = .secondaryLabel
    episodeLabel.numberOfLines = 0

    // URL label
    episodeUrlLabel.font = .systemFont(ofSize: 14)
    episodeUrlLabel.textColor = .secondaryLabel
    episodeUrlLabel.numberOfLines = 0
    episodeUrlLabel.lineBreakMode = .byTruncatingTail
    episodeUrlLabel.text = "View Episode"
    episodeUrlLabel.textColor = .systemBlue


    // StackView
    stackView.axis = .horizontal
    stackView.spacing = 12
    stackView.alignment = .center
    stackView.distribution = .fill
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.addSubview(stackView)

    [titleLabel, episodeLabel, episodeUrlLabel, scrollView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }

    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

      episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      episodeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      episodeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

      episodeUrlLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 4),
      episodeUrlLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      episodeUrlLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

      scrollView.topAnchor.constraint(equalTo: episodeUrlLabel.bottomAnchor, constant: 12),
      scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      scrollView.heightAnchor.constraint(equalToConstant: 70),
      scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    episodeLabel.text = nil
    episodeUrlLabel.text = nil
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
  }

  func configure(name: String, characters: [RMEpisodesCharacter], episodeLbl: String, episodeUrl: String) {
    titleLabel.text = name
    episodeLabel.text = episodeLbl
    episodeUrlLabel.text = episodeUrl
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    for char in characters.prefix(10) {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 30

      NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant: 60),
        imageView.heightAnchor.constraint(equalToConstant: 60)
      ])

      let wrapper = UIView()
      wrapper.translatesAutoresizingMaskIntoConstraints = false
      wrapper.addSubview(imageView)

      NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
        wrapper.widthAnchor.constraint(equalToConstant: 60),
        wrapper.heightAnchor.constraint(equalToConstant: 60)
      ])

      stackView.addArrangedSubview(wrapper)

      if let url = URL(string: char.image) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
          if let data = data {
            DispatchQueue.main.async {
              imageView.image = UIImage(data: data)
            }
          }
        }.resume()
      }
    }
  }
}
