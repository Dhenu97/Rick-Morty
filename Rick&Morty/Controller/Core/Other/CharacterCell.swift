//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import UIKit

final class CharacterCell: UICollectionViewCell {

  static let identifier = "CharacterCell"
  private let nameLabel = UILabel()

  private let characterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.cornerRadius = 10
    contentView.layer.borderWidth = 0.5

    contentView.addSubview(characterImageView)
    contentView.addSubview(nameLabel)
    nameLabel.font = .boldSystemFont(ofSize: 16)
    nameLabel.numberOfLines = 0 // or 0 for unlimited
    nameLabel.lineBreakMode = .byWordWrapping
    nameLabel.adjustsFontSizeToFitWidth = false

    characterImageView.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      characterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7), // 70% height for image

      nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 4),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  func configure(with character: RMCharacter) {
    nameLabel.text = character.name
    loadImage(urlString: character.image)
  }

  private func loadImage(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else { return }
      DispatchQueue.main.async {
        self.characterImageView.image = UIImage(data: data)
      }
    }.resume()
  }
}
