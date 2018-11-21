//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

class Huffman {
    private(set) var frequency: [Character: Int]
    private(set) var sorted = [Character]()

    init(_ input: String) {
        self.frequency = Huffman.sortedFrequency(for: input)
        // sorted by increasing frequency
        self.sorted = Array(self.frequency).sorted(by: {$0.1 < $1.1}).map{$0.0}
    }

    static private func sortedFrequency(for input: String) -> [Character: Int] {
        var frequency = [Character: Int]()
        for char in input {
            frequency[char] = (frequency[char] ?? 0) + 1
        }
        return frequency
    }
}
