//
//  ShoppingCartTests.swift
//  shoppingCartTests
//
//  Created by Justin Reid on 13/08/2024.
//

import XCTest
@testable import shoppingCart

class ShoppingCartTests: XCTestCase {
    
    var shoppingCart: ShoppingCarting!
    
    override func setUp() {
        shoppingCart = ShoppingCart(products: [.mockProduct1, .mockProduct2, .mockProduct3, .mockProduct4, .mockProduct5])
    }
    
    override func tearDown() {
        shoppingCart = nil
    }
    
    func testAddItemAddsItemSuccessfully() {
        
        shoppingCart.add(item: .mockProduct1)
        
        XCTAssertEqual(shoppingCart.products.count, 6)
    }
    
    func testRemoveItemRemovesItemSuccessfully() {
        
        shoppingCart.removeItem(with: "001")
        
        // Assert: Check that the product is no longer in the cart
        XCTAssertFalse(shoppingCart.products.contains(where: { $0.id == "001" }), "Product with id '001' should be removed from the cart")
        XCTAssertEqual(shoppingCart.products.count, 4)
    }
    
    func testClearCartClearsTheCart() {
        
        shoppingCart.clearCart()
        
        XCTAssertEqual(shoppingCart.products.count, 0)
    }
}
