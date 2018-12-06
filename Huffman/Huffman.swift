//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

struct HuffData: Codable {
    var code: [String]
    var frequencyTable: [String: String]
}

class Huffman {
    static func decode(_ data: Data) throws -> String {
        do {
            let huff = try JSONDecoder().decode(HuffData.self, from: data)
            let reverseTable = Dictionary(uniqueKeysWithValues: zip(huff.frequencyTable.values, huff.frequencyTable.keys))
            return huff.code.compactMap({ reverseTable[$0]}).joined()
        }
        catch let error {
            throw error
        }
    }

    static func encode(_ input: String) throws -> Data {
        let frequencyTable = Huffman.buildFrequencyTable(for: input)
        let code = input.compactMap({frequencyTable[String($0)]})
        let huff = HuffData(code: code, frequencyTable: frequencyTable)
        do {
            let data = try JSONEncoder().encode(huff)
            return data
        }
        catch let error {
            throw error
        }
    }
    
    static private func buildFrequencyTable(for input: String) -> [String: String] {
        // count letter frequency
        let sortedFrequency = input.reduce(into: [String: Int](), { freq, char in
            freq[String(char), default: 0] += 1
        })
        // create queue of initial Nodes
        let queue = sortedFrequency.map{ Node(name: $0.key, value: $0.value)}
        // generate key by traversing tree
        return Huffman.generateKey(for: Huffman.createTree(with: queue), prefix: "")
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
        // initialize queue that sorts by decreasing count
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
    init(queue: [Node]){
        // assumes queue will always be sorted by decreasing count
        self.queue = queue.sorted(by: {$0.value > $1.value})
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
