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
    
    func testDecode() {
        let word = "MISSISSIPPI_RIVER!"
        let huff = Huffman(word)
        let decode = huff.decode()
        XCTAssertEqual(decode, word)
    }

    func testEqualWeight() {
        let word = "abcdefgh"
        let huff = Huffman(word)
        let decode = huff.decode()
        // frequencyTable should show all 0s and 1s as count of 3
        XCTAssertEqual(decode, word)
    }
    
    func testDecodeWithLongerInput() {
        let paragraph = "Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine."
        let huff = Huffman(paragraph)
        let decode = huff.decode()
        XCTAssertEqual(decode, paragraph)
    }
    
}
