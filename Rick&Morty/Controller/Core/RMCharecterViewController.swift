//
//  RMCharecterViewController.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import UIKit

class RMCharecterViewController: UIViewController {
  private let viewModel = RMCharecterViewModel()
  private var collectionView: UICollectionView!

  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 16
    layout.minimumInteritemSpacing = 16
    layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)

    let availableWidth = UIScreen.main.bounds.width - 12*2 - 16*2
    let width = availableWidth / 3
    layout.itemSize = CGSize(width: width, height: 140)

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)

    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(LocationInfoTableCell.self, forCellWithReuseIdentifier: LocationInfoTableCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self

    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Character"

    configureCollectionView()
    setupBinding()
    viewModel.fetchInitialCharacters()
    collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    setupBinding()
    viewModel.fetchInitialCharacters()
  }

  private func setupBinding() {
    viewModel.onCharactersUpdated = { [weak self] in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }


  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let frameHeight = scrollView.frame.size.height

    if offsetY > (contentHeight - frameHeight - 50) {
      viewModel.fetchMoreCharacters()

    }
  }

}

// MARK: - Collection View DataSource
extension RMCharecterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.characters.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: viewModel.characters[indexPath.row])

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let charec = viewModel.characters[indexPath.row]
    let charecViewModel = RMDetailedVM(character: charec)
    let charecterVc = RMDetailedVC(viewModel: charecViewModel)
    navigationController?.pushViewController(charecterVc, animated: true)
  }

}

