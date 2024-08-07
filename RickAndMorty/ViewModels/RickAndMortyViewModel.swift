//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 26.07.2024.
//

import Foundation
import Combine

final class RickAndMortyViewModel: ObservableObject {
    
    @Published var characterState: CharacterViewModelState = .initial
    
    let service: IRickAndMortyService = RickAndMortyService()
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getAllCharacters()
    }
    
    private func getAllCharacters() {
        characterState = .loading
        service.getAllCharacters()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("finish")
                case .failure(let error):
                    self?.characterState = .error(errorMessage: "\(error)")
                }
            } receiveValue: { [weak self] characters in
                self?.characterState = .loaded(characters: characters)
            }
            .store(in: &cancellable)
    }
}
