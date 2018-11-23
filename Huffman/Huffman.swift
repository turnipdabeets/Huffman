//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

class Huffman {
    private(set) var key = [String: String]()
    private(set) var code = [String]()

    init(_ input: String) {
        self.key = self.getKey(for: input)
        self.code = self.encode(for: input)
    }

    private func getKey(for input: String) -> [String: String]{
        let frequencyMap = Array(input).reduce(into: [String: Int](), { freq, char in
            let letter = String(char)
            return freq[letter] = (freq[letter] ?? 0) + 1
        })
        let sorted = Array(frequencyMap).sorted(by: {$0.1 > $1.1}).map{$0.0}
        // create queue of initial Nodes
        let queue = sorted.map{ Node(name: $0, value: frequencyMap[$0]!)}
        return generateKey(for: createTree(with: queue), prefix: "")
    }

    private func encode(for input: String) -> [String] {
        var code = [String]()
        for char in input {
            if let prefix = key[String(char)] {
                code.append(prefix)
            }
        }
        return code
    }

    func decode(_ code: [String], with key: [String: String]) -> String {
        var reverseKey = [String:String]()
        for (k, v) in key {
            reverseKey[v] = k
        }
        var word = ""
        for prefix in code {
            if let letter = reverseKey[prefix] {
                word += letter
            }
        }
        return word
    }

    private func sortedFrequency(for input: String) -> [String: Int] {
        var frequency = [String: Int]()
        for char in input {
            let letter = String(char)
            frequency[letter] = (frequency[letter] ?? 0) + 1
        }
        return frequency
    }

    private func generateKey(for node: Node, prefix: String) -> [String: String] {
        var key = [String: String]()
        if let left = node.left, let right = node.right {
            key.merge(generateKey(for: left, prefix: prefix + "0"), uniquingKeysWith: {current,_ in current})
            key.merge(generateKey(for: right, prefix: prefix + "1"), uniquingKeysWith: {current,_ in current})
        }else {
            key[node.name] = prefix
        }
        return key
    }

    private func createTree(with queue: [Node]) -> Node {
        var queue = queue
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
