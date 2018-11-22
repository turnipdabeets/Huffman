//
//  HuffmanTests.swift
//  HuffmanTests
//
//  Created by Anna Elisabeth Garcia on 11/21/18.
//  Copyright © 2018 Anna Elisabeth Garcia. All rights reserved.
//

import XCTest
@testable import Huffman

class HuffmanTests: XCTestCase {

    func testFrequencyCountOnInput() {
        let huff = Huffman("ANNA").frequency
        let expected: [String: Int] = ["A": 2, "N": 2]
        XCTAssertEqual(huff, expected)
    }

    func testSortedFrequency() {
        let huff = Huffman("ZZZNZZZZAZGAATAANNT")
        let expected: [String] = ["Z", "A", "N", "T", "G"]
        XCTAssertEqual(huff.sorted, expected)
    }

    func testTreeCreation() {
        let string = "MISSISSIPPI_RIVER!"
        let huff = Huffman(string)
        let tree = huff.createTree()
        XCTAssertEqual(tree.value, string.count)
    }

    func testingKeyGeneration() {
        let huff = Huffman("SUCCESS")
        XCTAssertEqual(huff.key["S"]!.count, 1)
        XCTAssertEqual(huff.key["E"]!.count, 3)
    }

}
