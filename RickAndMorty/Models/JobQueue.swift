//
//  JobQueue.swift
//  RickAndMorty
//
//  Created by Анастасия Леонтьева on 19.08.2024.
//

import Foundation

public struct JobQueue<T> {

    public init() { }

    private var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        guard !array.isEmpty, let element = array.first else { return nil }

        array.remove(at: array.startIndex)

        return element
    }
    
    public func peek() -> T? {
        return array.first
    }
}
