//
//  IRickAndMortyService.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 26.07.2024.
//

import Foundation
import Combine

protocol IRickAndMortyService {
    func getAllCharacters() -> AnyPublisher<Characters, Error>
}
