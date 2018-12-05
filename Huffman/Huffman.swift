//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

class Huffman {
    private var frequencyTable = [String: String]()
    private(set) var code = [String]()
    
    init(_ input: String) {
        self.frequencyTable = Huffman.buildFrequencyTable(for: input)
        self.code = Huffman.encode(for: input, with: self.frequencyTable)
    }

    func decode() -> String {
        let reverseTable = Dictionary(uniqueKeysWithValues: zip(frequencyTable.values, frequencyTable.keys))
        return code.compactMap({ reverseTable[$0]}).joined()
    }
    
    static private func buildFrequencyTable(for input: String) -> [String: String] {
        // sort letter frequency by decreasing count
        let sortedFrequency = input
            .reduce(into: [String: Int](), { freq, char in
                freq[String(char), default: 0] += 1
            })
            .sorted(by: {$0.value > $1.value})
        // create queue of initial Nodes
        let queue = sortedFrequency.map{ Node(name: $0.key, value: $0.value)}
        // generate key by traversing tree
        return Huffman.generateKey(for: Huffman.createTree(with: queue), prefix: "")
    }
    
    static private func encode(for input: String, with key: [String: String]) -> [String] {
        return input.compactMap({key[String($0)]})
    }

    static private func generateKey(for node: Node, prefix: String) -> [String: String] {
        var key = [String: String]()
        if let left = node.left, let right = node.right {
            key.merge(generateKey(for: left, prefix: prefix + "0"), uniquingKeysWith: {current,_ in current})
            key.merge(generateKey(for: right, prefix: prefix + "1"), uniquingKeysWith: {current,_ in current})
        }else {
            key[node.name] = prefix
        }
        return key
    }
    
    static private func createTree(with queue: [Node]) -> Node {
        var queue = PriorityQueue(queue: queue)
        // until we have 1 root node, join subtrees of least frequency
        while queue.count > 1 {
            let node1 = queue.dequeue()
            let node2 = queue.dequeue()
            let rootNode = Huffman.createRoot(with: node1, and: node2)
            queue.enqueue(node: rootNode)
        }
        return queue.queue[0]
    }
    
    static private func createRoot(with first: Node, and second: Node) -> Node {
        return Node(name: "\(first.name)\(second.name)", value: first.value + second.value, left: first, right: second)
    }
    
}

// TODO:  - move sorting to PriorityQueue init
struct PriorityQueue {
    var queue: [Node]
    var count: Int {
        return queue.count
    }
    mutating func enqueue(node: Node) {
        queue.insert(node, at: queue.index(where: {$0.value <= node.value}) ?? 0)
    }
    mutating func dequeue() -> Node {
        return queue.removeLast()
    }
}

class Node: CustomStringConvertible {
    var description: String {
        return "\(name): \(value)"
    }
    let name: String
    let value: Int
    let left: Node?
    let right: Node?
    
    init(name: String, value: Int, left: Node? = nil, right: Node? = nil) {
        self.name = name
        self.value = value
        self.left = left
        self.right = right
    }
}

