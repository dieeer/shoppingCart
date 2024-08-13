//
//  CashierTests.swift
//  shoppingCartTests
//
//  Created by Justin Reid on 13/08/2024.
//

import XCTest
@testable import shoppingCart

final class ShoppingCartSpy: ShoppingCart {
    var addCalled = false
    var removeItemCalled = false
    var clearCartCalled = false
    
    override func add(item: Product) {
        addCalled = true
    }
    
    override func removeItem(with id: String) {
        removeItemCalled = true
    }
    
    override func clearCart() {
        clearCartCalled = true
    }
}

final class DiscounterSpy: Discounting {
    var applyDiscountToCartCalled = false
    var applyDiscountToProductCalled = false
    var applyBuyTwoGetOneFreeCalled = false
    var applyComboDealCalled = false
    
    func apply(discount: Decimal, toCart cart: ShoppingCart) {
        applyDiscountToCartCalled = true
    }
    
    func apply(discount: Decimal, toProduct product: Product) {
        applyDiscountToProductCalled = true
    }
    
    func applyBuyTwoGetOneFree(to cart: ShoppingCart, for category: shoppingCart.Category) {
        applyBuyTwoGetOneFreeCalled = true
    }
    
    func applyComboDeal(to cart: ShoppingCart, for promotion: Promotion) {
        applyComboDealCalled = true
    }
}

final class CashierTests: XCTestCase {
    var cart: ShoppingCartSpy!
    var discounter: DiscounterSpy!
    var cashier: Cashier!
    
    override func setUp() {
        super.setUp()
        cart = ShoppingCartSpy()
        discounter = DiscounterSpy()
        cashier = Cashier(cart: cart, discounter: discounter)
    }
    
    override func tearDown() {
        cart = nil
        discounter = nil
        cashier = nil
        super.tearDown()
    }
    
    func testApplyDiscountToCartIsCalled() {
        cashier.applyDiscountToCart(discount: 10)
        XCTAssertTrue(discounter.applyDiscountToCartCalled)
    }
    
    func testApplyDiscountToProductIsCalled() {
        let product = Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00))
        cart.products = [product]
        cashier.applyDiscountToProduct(productId: "001", discount: 20)
        XCTAssertTrue(discounter.applyDiscountToProductCalled)
    }
    
    func testApplyBuyTwoGetOneFreeIsCalled() {
        let product1 = Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00))
        let product2 = Product(id: "002", category: .suspension, name: "Strut", SKU: "S124", price: Decimal(80.00))
        let product3 = Product(id: "003", category: .suspension, name: "Coil Spring", SKU: "S125", price: Decimal(120.00))
        cart.products = [product1, product2, product3]
        
        cashier.applyBuyTwoGetOneFree(category: .suspension)
        
        XCTAssertTrue(discounter.applyBuyTwoGetOneFreeCalled)
    }
    
    func testApplyComboDealIsCalled() {
        let product1 = Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00))
        let product2 = Product(id: "002", category: .exhaust, name: "Exhaust Pipe", SKU: "E456", price: Decimal(80.00))
        cart.products = [product1, product2]
        
        let promotion = Promotion(name: "Combo Deal", requiredItems: [product1, product2], setPrice: Decimal(200.00))
        cashier.applyComboDeal(promotion: promotion)
        
        XCTAssertTrue(discounter.applyComboDealCalled)
    }
    
    func testShowCartReturnsCorrectly() {
        cart.products = [
            Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00)),
            Product(id: "002", category: .exhaust, name: "Exhaust Pipe", SKU: "E456", price: Decimal(80.00)),
            Product(id: "003", category: .suspension, name: "Spring", SKU: "S789", price: Decimal(70.00))
        ]
        
        let expected: [String: Decimal] = [
            "Shock Absorber": Decimal(150.00),
            "Exhaust Pipe": Decimal(80.00),
            "Spring": Decimal(70.00)
        ]
        
        XCTAssertEqual(cashier.showCart(), expected)
    }
}
