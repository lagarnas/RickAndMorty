//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 26.07.2024.
//

import Foundation
import Combine

final class RickAndMortyService: IRickAndMortyService {
    
    func getAllCharacters() -> AnyPublisher<Characters, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://rickandmortyapi.com/api/character")!)
            .map { $0.data }
            .decode(type: Characters.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
