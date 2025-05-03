//
//  ViewController.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import UIKit

final class ViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTabs()

  }

 private func setUpTabs() {
   let charecterVc = RMCharecterViewController()
   let locationVc = RMLocationViewController()
   let episodeVc = RMEpisodeViewController()

   charecterVc.navigationItem.largeTitleDisplayMode = .automatic
   locationVc.navigationItem.largeTitleDisplayMode = .automatic
   episodeVc.navigationItem.largeTitleDisplayMode = .automatic
 
   let nav1 = UINavigationController(rootViewController: charecterVc)
   let nav2 = UINavigationController(rootViewController: locationVc)
   let nav3 = UINavigationController(rootViewController: episodeVc)

   nav1.tabBarItem = UITabBarItem(title: "Charecters", image: UIImage(systemName: "person"), tag: 1)
   nav2.tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "location"), tag: 2)
   nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "movieclapper"), tag: 3)

   for nav in [nav1, nav2, nav3] {
     nav.navigationBar.prefersLargeTitles = true
   }
   setViewControllers([nav1, nav2, nav3], animated: true)
  }

}

