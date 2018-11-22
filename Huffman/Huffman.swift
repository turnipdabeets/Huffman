//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

class Huffman {
    private(set) var frequency: [String: Int]
    private(set) var sorted = [String]()
    private(set) var key = [String: String]()

    init(_ input: String) {
        self.frequency = Huffman.sortedFrequency(for: input)
        // sorted by decreasing frequency
        self.sorted = Array(self.frequency).sorted(by: {$0.1 > $1.1}).map{$0.0}
        // generate encoded key map
        self.key = generateKey(for: self.createTree(), prefix: "")
    }

    static private func sortedFrequency(for input: String) -> [String: Int] {
        var frequency = [String: Int]()
        for char in input {
            let letter = String(char)
            frequency[letter] = (frequency[letter] ?? 0) + 1
        }
        return frequency
    }

    func generateKey(for node: Node, prefix: String) -> [String: String] {
        var key = [String: String]()
        if let left = node.left, let right = node.right {
            key.merge(generateKey(for: left, prefix: prefix + "0"), uniquingKeysWith: {current,_ in current})
            key.merge(generateKey(for: right, prefix: prefix + "1"), uniquingKeysWith: {current,_ in current})
        }else {
            key[node.name] = prefix
        }
        return key
    }

    func createTree() -> Node {
        // create queue of initial Nodes
        var queue = sorted.map{ Node(name: $0, value: frequency[$0]!)}

        // until we have 1 root node, get subtree of least frequency
        while queue.count > 1 {
            let last = queue.count - 1
            let node1 = queue[last]
            let node2 = queue[last - 1]

            // if we have a third then compare frequency to second
            if let node3 = queue[safe: last - 2], node3.value + node2.value < node2.value + node1.value {
                queue.remove(at: last - 1)
                queue.remove(at: last - 2)
                queue.append(createRoot(with: node2, and: node3))
            } else {
                queue.removeLast()
                queue.removeLast()
                queue.append(createRoot(with: node1, and: node2))
            }
        }
        return queue[0]
    }

    private func createRoot(with first: Node, and second: Node) -> Node {
        return Node(name: "\(first.name)\(second.name)", value: first.value + second.value, left: first, right: second)
    }

}

class Node: CustomStringConvertible {
    var description: String {
        return "\(name): \(value)"
    }
    var name: String
    var value: Int
    var left: Node?
    var right: Node?

    init(name: String, value: Int, left: Node? = nil, right: Node? = nil) {
        self.name = name
        self.value = value
        self.left = left
        self.right = right
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
