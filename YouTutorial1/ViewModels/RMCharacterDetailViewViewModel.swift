//
//  RMCharacterDetailViewViewModel.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/12/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
