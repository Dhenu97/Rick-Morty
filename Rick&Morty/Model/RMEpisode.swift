//
//  RMEpisode.swift
//  Rick&Morty
//
//  Created by dhenu on 3/12/25.
//

import Foundation

// MARK: - EpisodeResponse
struct EpisodeResponse: Codable {
    let info: EpisodeInfo
    let results: [RMEpisode]
}

// MARK: - Info
struct EpisodeInfo: Codable {
    let count, pages: Int
    let next: String?
  let prev: String?
}

// MARK: - Result
struct RMEpisode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
}

struct RMEpisodesCharacter: Codable {
    let image: String
}
