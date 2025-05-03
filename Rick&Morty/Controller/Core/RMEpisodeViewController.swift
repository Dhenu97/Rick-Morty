//
//  RMEpisodeViewController.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import UIKit

class RMEpisodeViewController: UIViewController, UICollectionViewDelegate {

  private var collectionView: UICollectionView!
  var episodeVM = RMEpisodeVM()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Episodes"
    configureCollectionView()
    setupBinding()
    episodeVM.fetchInitialCharacters()
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
   let offsetY = scrollView.contentOffset.y
   let contentHeight = scrollView.contentSize.height
   let frameHeight = scrollView.frame.size.height

   if offsetY > (contentHeight - frameHeight - 50) {
     episodeVM.fetchMoreCharacters()

   }
 }


  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10

    let width = UIScreen.main.bounds.width - 32
    layout.itemSize = CGSize(width: width, height: 200)

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .systemBackground
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(EpisodeCollectionCell.self, forCellWithReuseIdentifier: EpisodeCollectionCell.identifier)
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

  override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 12
    layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)

    let width = view.bounds.width - 32
    layout.itemSize = CGSize(width: width, height: 160) // Customize height

  }

  private func setupBinding() {
    episodeVM.onEpisodeUpdated = { [weak self] in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }
}

// MARK: - Collection View DataSource
extension RMEpisodeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return episodeVM.episodeArray.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionCell.identifier, for: indexPath) as? EpisodeCollectionCell else {
      return UICollectionViewCell()
    }

    let episode = episodeVM.episodeArray[indexPath.item]

    cell.configure(name: episode.name, characters: [], episodeLbl: episode.episode, episodeUrl: episode.url)

    episodeVM.fetchCharacters(from: episode.characters) { characters in
      DispatchQueue.main.async {
        // Ensure cell is still visible
        if let visibleCell = collectionView.cellForItem(at: indexPath) as? EpisodeCollectionCell {
          let formattedString = """
          Episode: \(episode.episode)
          Air Date: \(episode.airDate)
          """
          visibleCell.configure(name: episode.name, characters: characters, episodeLbl: formattedString , episodeUrl: episode.url)
        }
      }
    }

    return cell
  }

  
}


