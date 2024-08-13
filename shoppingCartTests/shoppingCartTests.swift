//
//  ShoppingCartTests.swift
//  shoppingCartTests
//
//  Created by Justin Reid on 13/08/2024.
//

import XCTest
@testable import shoppingCart

class ShoppingCartTests: XCTestCase {
    
    var shoppingCart: ShoppingCart!
    
    override func setUp() {
        shoppingCart = ShoppingCart()
    }
    
    override func tearDown() {
        shoppingCart = nil
    }
    
    private func addMockProducts() {
        shoppingCart.products = [.mockProduct1, .mockProduct2, .mockProduct3, .mockProduct4, .mockProduct5]
    }
    
    func testInitSetsUpCartCorrectly() {
            
        XCTAssertTrue(shoppingCart.products.isEmpty)
    }
    
    
    func testAddItemAddsItem() {
                
        shoppingCart.add(item: .mockProduct1)
        
        XCTAssertEqual(shoppingCart.products.count, 1)
    }
    
    func testRemoveItemRemovesItem() {
        
        addMockProducts()
        
        shoppingCart.removeItem(with: "001")
        
        XCTAssertFalse(shoppingCart.products.contains(where: { $0.id == "001" }), "id '001' should be removed from the cart")
        XCTAssertEqual(shoppingCart.products.count, 4)
    }
    
    func testClearCartClearsTheCart() {
        
        addMockProducts()
        
        shoppingCart.clearCart()
        
        XCTAssertEqual(shoppingCart.products.count, 0)
    }
    
    func testTotalPriceDisplaysCorrectly() {
        
        addMockProducts()
        
        XCTAssertEqual(shoppingCart.totalPrice(), 1059.95)
    }
}
