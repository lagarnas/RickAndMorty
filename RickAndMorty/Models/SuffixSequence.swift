//
//  SuffixSequence.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 06.08.2024.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    let word: String
    var index: Int = 0
    
    mutating func next() -> String? {
        guard index <= word.count else { return nil }
        index += 1
        return String(word.suffix(index))
    }
}

struct SuffixSequence: Sequence {
    
    let word: String
    
    func makeIterator() -> some IteratorProtocol {
        SuffixIterator(word: word)
    }
}
