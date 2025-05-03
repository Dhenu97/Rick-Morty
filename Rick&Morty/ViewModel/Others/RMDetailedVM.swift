//
//  RMDetailedVM.swift
//  Rick&Morty
//
//  Created by dhenu on 4/28/25.
//

import Foundation

class RMDetailedVM {

  private var character: RMCharacter

  init(character: RMCharacter) {
    self.character = character
  }

  var characterName: String {
    return character.name
  }

  var characterSpecies: String {
    return character.species
  }

  var characterStatus: String {
    return character.status.rawValue.capitalized
  }

  var characterGender: String {
    return character.gender.capitalized
  }

  var characterImageURL: String? {
    return character.image
  }

  var characterOriginName: String {
    return character.origin?.name ?? ""
  }

  var characterLocationName: String {
    return character.location?.name ?? ""
  }

  var numberOfEpisodes: Int {
    return character.episode.count
  }

  struct CharacterPhotoViewModel {
      let imageURL: URL?
      let characterName: String
      let characterDescription: String?

      init(character: RMCharacter) {
          self.imageURL = URL(string: character.image)
          self.characterName = character.name
          self.characterDescription = character.url
      }
  }

  var photoViewModel: CharacterPhotoViewModel {
          return CharacterPhotoViewModel(character: character)
      }

  struct CharacterInfoViewModel {
    var title: String
    var value: String
  }

  var infoViewModel: [CharacterInfoViewModel] {
      return [
          CharacterInfoViewModel(title: "Status", value: characterStatus),
          CharacterInfoViewModel(title: "Species", value: characterSpecies),
          CharacterInfoViewModel(title: "Gender", value: characterGender),
          CharacterInfoViewModel(title: "Origin", value: characterOriginName),
          CharacterInfoViewModel(title: "Location", value: characterLocationName),
          CharacterInfoViewModel(title: "Episodes", value: "\(numberOfEpisodes)")
      ]
  }

}





