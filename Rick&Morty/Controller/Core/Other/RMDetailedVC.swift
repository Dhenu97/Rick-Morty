//
//  RMDetailedVC.swift
//  Rick&Morty
//
//  Created by dhenu on 4/28/25.
//

import UIKit

class RMDetailedVC: UITableViewController {

    private let photoViewModel: RMDetailedVM.CharacterPhotoViewModel
    private let infoViewModel: [RMDetailedVM.CharacterInfoViewModel]

    init(viewModel: RMDetailedVM) {
        self.photoViewModel = viewModel.photoViewModel
        self.infoViewModel = viewModel.infoViewModel
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PhotoTableCell.self, forCellReuseIdentifier: PhotoTableCell.identifier)
        tableView.register(InfoTableCell.self, forCellReuseIdentifier: InfoTableCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // photo + info
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : infoViewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCell.identifier, for: indexPath) as? PhotoTableCell else {
                return UITableViewCell()
            }
            cell.configure(with: photoViewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.identifier, for: indexPath) as? InfoTableCell else {
                return UITableViewCell()
            }
            cell.configure(with: infoViewModel[indexPath.row])
            return cell
        }
    }
}

final class PhotoTableCell: UITableViewCell {

    static let identifier = "PhotoTableCell"

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

  func configure(with viewModel: RMDetailedVM.CharacterPhotoViewModel) {
       nameLabel.text = viewModel.characterName

       if let image = viewModel.imageURL {
           URLSession.shared.dataTask(with: image) { data, _, _ in
               guard let data = data else { return }
               DispatchQueue.main.async {
                   self.characterImageView.image = UIImage(data: data)
               }
           }.resume()
       }

       if let urls = viewModel.characterDescription?.components(separatedBy: ",") {
           descriptionLabel.text = urls.joined(separator: "\n")
       } else {
           descriptionLabel.text = viewModel.characterDescription
       }
   }
}

final class InfoTableCell: UITableViewCell {
    static let identifier = "InfoTableCell"

    func configure(with viewModel: RMDetailedVM.CharacterInfoViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.value
        textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
