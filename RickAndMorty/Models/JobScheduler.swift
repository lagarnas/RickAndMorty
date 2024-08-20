//
//  JobScheduler.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 20.08.2024.
//

import Foundation

actor JobScheduler {
    
    func run(after delay: Int, completion: @escaping () async -> Void) {
        Task {
            try await Task.sleep(nanoseconds: UInt64( delay * 1_000_000_000))
            await completion()
        }
    }
}
