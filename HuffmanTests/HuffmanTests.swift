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
    
    func testEncodedBytes() {
        let huffCode = try? Huffman.encode("abcdefgh")
        print("abcdefgh".utf8.count)
        print(huffCode)
//        XCTAssertEqual(huffCode?.count, 157)
    }

    func testEncode(){
        let word = "MISSISSIPPI_RIVER!"
        print("HD", word.utf8.count)
        let encoded = try? Huffman.encode(word)
        XCTAssertNotNil(encoded)
    }

    func testDecode() {
        let word = "Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade.   Unicorn squid gentrify letterpress bitters single-origin coffee. "
//        let word = "MISSISSIPPI_RIVER!"
        print("HD", word.utf8.count)
        let encoded = try! Huffman.encode(word)
        let decode = try? Huffman.decode(encoded)
        print("DECODE", decode)
        XCTAssertEqual(decode, word)
    }

    //    func testEqualWeight() {
    //        let word = "abcdefgh"
    //        let huff = Huffman(word)
    //        let decode = huff.decode()
    //        // frequencyTable should show all 0s and 1s as count of 3
    //        XCTAssertEqual(decode, word)
    //    }

    func testDecodeWithLongerInput() {
        let paragraph = "Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine. Farm-to-table glossier organic beard four loko wayfarers, biodiesel ugh. Cliche flexitarian kogi health goth direct trade. Unicorn squid gentrify letterpress bitters single-origin coffee. Locavore flannel woke sustainable ethical tofu aesthetic pabst marfa pug knausgaard man braid tilde. Fashion axe PBR&B kogi gentrify vegan woke prism health goth. Vaporware flannel yuccie ethical artisan hella VHS church-key, cronut gluten-free 8-bit poutine."
print("HD", paragraph.utf8.count)
        let huff = try? Huffman.encode(paragraph)
        print("p bytes", paragraph.utf8.count)
        print("data bytes", huff?.count)
        let decode = try? Huffman.decode(huff!)
        XCTAssertEqual(decode, paragraph)
    }

}
