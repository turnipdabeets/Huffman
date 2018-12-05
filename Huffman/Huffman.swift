//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

class Huffman {
    private var key = [String: String]()
    private(set) var code = [String]()
    
    init(_ input: String) {
        self.key = Huffman.getKey(for: input)
        self.code = Huffman.encode(for: input, with: self.key)
    }

    func decode() -> String {
        let reverseKey = Dictionary(uniqueKeysWithValues: zip(key.values, key.keys))
        return code.compactMap({ reverseKey[$0]}).joined()
    }
    
    static private func getKey(for input: String) -> [String: String] {
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
        var queue = queue
        // until we have 1 root node, get subtree of least frequency
        while queue.count > 1 {
            let last = queue.count - 1
            let node1 = queue[last]
            let node2 = queue[last - 1]
            let node3 = queue.count >= 3 ? queue[last - 2] : nil
            
            // if we have a third then compare frequency to second
            if let node3 = node3, node3.value + node2.value < node2.value + node1.value {
                queue.remove(at: last - 1)
                queue.remove(at: last - 2)
                queue.append(Huffman.createRoot(with: node2, and: node3))
            } else {
                queue.removeLast()
                queue.removeLast()
                queue.append(Huffman.createRoot(with: node1, and: node2))
            }
        }
        return queue[0]
    }
    
    static private func createRoot(with first: Node, and second: Node) -> Node {
        return Node(name: "\(first.name)\(second.name)", value: first.value + second.value, left: first, right: second)
    }
    
}

class Node {
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

