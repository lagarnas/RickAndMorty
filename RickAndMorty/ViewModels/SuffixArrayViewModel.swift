//
//  SuffixArrayViewModel.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 05.08.2024.
//

import Foundation
import SwiftUI
import Combine

enum SortType {
    case ASC
    case DESC
}

class SuffixArrayViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var allSuffixes: Array<(key: String, value: Int)> = []
    @Published var topSuffixes: Array<(key: String, value: Int)> = []
    
    private var cancellable: AnyCancellable?
    private var suffixesDict: [String: Int] = [:]
    
    init() {
        getSuffixes()
    }
    
    // MARK: - Public
    
    func sortSuffixes(by sortType: SortType) {
        switch sortType {
        case .ASC:
            allSuffixes = suffixesDict.sorted(by: <)
        case .DESC:
            allSuffixes = suffixesDict.sorted(by: >)
        }
    }
    
    // MARK: - Private
    
    private func getSuffixes() {
        cancellable = $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .map({ $0.lowercased() })
            .sink { [weak self] text in
                guard let self else { return }
                let words = text.split(separator: " ")
                let suffixArray = words.flatMap{ SuffixSequence(word: String($0)).map { $0 } }
                self.suffixesDict = suffixArray.reduce(into: [:]) { result, str in
                    result[str as! String, default: 0] += 1
                }
                self.sortSuffixes(by: .ASC)
                self.getTopSuffixes()
            }
    }
    
    private func getTopSuffixes() {
        topSuffixes = allSuffixes
            .filter { $0.key.count == 3 }
            .sorted { $0.value > $1.value }
    }
}
