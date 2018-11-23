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

    func testEncoded() {
        let huffCode = Huffman("MISSISSIPPI_RIVER").code
        XCTAssertEqual(huffCode.joined().count, 46)
    }

    func testKeyCountMatchesUniqueLetters() {
        let word = "SUCCESS"
        var uniqueLetters = Set<Character>()
        word.forEach{ char in
            uniqueLetters.insert(char)
        }
        let huff = Huffman(word)
        XCTAssertEqual(huff.key.count, uniqueLetters.count)
    }

    func testDecode() {
        let word = "MISSISSIPPI_RIVER!"
        let huff = Huffman(word)
        let decode = huff.decode(huff.code, with: huff.key)
        XCTAssertEqual(decode, word)
    }

}
