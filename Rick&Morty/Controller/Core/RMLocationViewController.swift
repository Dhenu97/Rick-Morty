//
//  RMLocationViewController.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import UIKit

class RMLocationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  var locationVM = LocationViewModel()
  private var collectionView: UICollectionView!

  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 16

    let width = UIScreen.main.bounds.width - 32
    layout.itemSize = CGSize(width: width, height: 140)

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    view.backgroundColor = .systemBackground
    title = "Location"
    configureCollectionView()
    setupBinding()
    locationVM.fetchInitialCharacters()
  }

  private func setupBinding() {
    locationVM.onLocationUpdated = { [weak self] in
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
      locationVM.fetchMoreCharacters()

    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  locationVM.locationArray.count
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationInfoTableCell.identifier, for: indexPath) as? LocationInfoTableCell else {
      return UICollectionViewCell()
    }
    let location = locationVM.locationArray[indexPath.row]

        locationVM.fetchCharacters(from: location.residents) { characters in
            DispatchQueue.main.async {
                cell.configure(name: "Location: \(location.name)", characters: characters)
            }
        }
    return cell
  }

}


