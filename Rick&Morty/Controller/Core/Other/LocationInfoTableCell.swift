//
//  LocationInfoTableCell.swift
//  Rick&Morty
//
//  Created by dhenu on 4/30/25.
//

import UIKit

final class LocationInfoTableCell: UICollectionViewCell {
    static let identifier = "LocationInfoTableCell"

    private let titleLabel = UILabel()
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
      titleLabel.font = .boldSystemFont(ofSize: 16)
      titleLabel.numberOfLines = 0
      titleLabel.lineBreakMode = .byWordWrapping

       stackView.axis = .horizontal
       stackView.spacing = 12
       stackView.alignment = .center
       stackView.distribution = .equalSpacing

       scrollView.showsHorizontalScrollIndicator = false
       scrollView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

       contentView.addSubview(titleLabel)
       contentView.addSubview(scrollView)
       scrollView.addSubview(stackView)

       [titleLabel, scrollView, stackView].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
       }

       NSLayoutConstraint.activate([
           titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
           titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

           scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
           scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
           scrollView.heightAnchor.constraint(equalToConstant: 70),

           stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
           stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
           stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
       ])
    }

    func configure(name: String, characters: [RMLiteCharacter]) {
        titleLabel.text = name
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for char in characters.prefix(10) {
            let iv = UIImageView()
            iv.layer.cornerRadius = 30
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFill
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
            iv.heightAnchor.constraint(equalToConstant: 60).isActive = true

            if let url = URL(string: char.image) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            iv.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }

            stackView.addArrangedSubview(iv)
        }
    }
}




