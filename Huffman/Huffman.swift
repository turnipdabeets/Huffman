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
    
    static private func getKey(for input: String) -> [String: String] {
        // sort letter frequency by decreasing count
        let sortedFrequency = Array(input)
            .reduce(into: [String: Int](), { freq, char in
                let letter = String(char)
                return freq[letter] = freq[letter, default: 0] + 1
            })
            .sorted(by: {$0.1 > $1.1})
        // create queue of initial Nodes
        let queue = sortedFrequency.map{ Node(name: $0.key, value: $0.value)}
        // generate key by traversing tree
        return Huffman.generateKey(for: Huffman.createTree(with: queue), prefix: "")
    }
    
    static private func encode(for input: String, with key: [String: String]) -> [String] {
        var code = [String]()
        for char in input {
            if let prefix = key[String(char)] {
                code.append(prefix)
            }
        }
        return code
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
            
            // if we have a third then compare frequency to second
            if let node3 = queue[safe: last - 2], node3.value + node2.value < node2.value + node1.value {
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
