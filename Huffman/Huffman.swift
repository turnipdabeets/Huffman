//
//  Huffman.swift
//  Huffman
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import Foundation

struct HuffData: Codable {
    var code: [UInt8]
    var tree: Node
    var pad: Int
}

class Huffman {
    static func decode(_ data: Data) throws -> String {
        let huff = try JSONDecoder().decode(HuffData.self, from: data)
        var bits: String = ""
        // return bits to a string O and 1
        for i in huff.code {
            var str = String(i, radix: 2)
            // if bits originally started with zeros, that was removed e.g. 32
            if str.count < 8 {
                str = String(repeating: "0", count: 8 - str.count) + str
            }
            bits += str
        }
        return Huffman.traverse(tree: huff.tree, with: String(bits.dropLast(huff.pad)))
    }

    static func encode(_ input: String) throws -> Data {
        // count letter frequency
        let sortedFrequency = input.reduce(into: [String: Int](), { freq, char in
            freq[String(char), default: 0] += 1
        })
        // create queue of initial Nodes
        let queue = sortedFrequency.map{ Node(name: $0.key, value: $0.value)}
        // create tree
        let tree = Huffman.createTree(with: queue)
        // generate key by traversing tree
        let key = Huffman.generateKey(for: tree, prefix: "")
        // bit packed code
        let code = input.compactMap({key[String($0)]}).joined()
        let buffer = Huffman.packBits(for: code)
        // save data
        let huff = HuffData(code: buffer.code, tree: tree, pad: buffer.pad)
        let data = try JSONEncoder().encode(huff)
        return data
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

    static private func traverse(tree: Node, with code: String) -> String {
        var result = ""
        var node = tree
        for bit in code {
            if bit == "0", let left = node.left {
                node = left
            } else if bit == "1", let right = node.right {
                node = right
            }
            if node.left == nil && node.right == nil {
                result += node.name
                node = tree
            }
        }
        return result
    }
    
    static private func createRoot(with first: Node, and second: Node) -> Node {
        return Node(name: "\(first.name)\(second.name)", value: first.value + second.value, left: first, right: second)
    }

    static private func packBits(for s: String) -> (pad: Int, code: [UInt8]) {
        var result = [UInt8]()
        // pad with extra "0"'s to a length that is exact multiple of 8
        let padding = 8 - (s.count % 8)
        var bits = s + String(repeating: "0", count: padding)
        // convert 8 bits at a time to a byte
        while !bits.isEmpty {
            result.append(UInt8(bits.prefix(8), radix: 2)!)
            bits = String(bits.dropFirst(8))
        }
        return (pad: padding, code: result)
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

class Node: CustomStringConvertible, Codable {
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
