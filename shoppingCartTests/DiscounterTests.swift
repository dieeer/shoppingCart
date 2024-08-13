//
//  DiscountingTests.swift
//  shoppingCartTests
//
//  Created by Justin Reid on 13/08/2024.
//

import XCTest
@testable import shoppingCart

final class DiscounterTests: XCTestCase {

    var cart: ShoppingCart!
    var discounter: Discounter!

    override func setUp() {
        super.setUp()
        cart = ShoppingCart()
        discounter = Discounter()
    }

    override func tearDown() {
        cart = nil
        discounter = nil
        super.tearDown()
    }

    private func addMockProducts() {
        cart.products = [
            Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00)),
            Product(id: "002", category: .exhaust, name: "Exhaust Pipe", SKU: "E456", price: Decimal(80.00)),
            Product(id: "003", category: .suspension, name: "Spring", SKU: "S789", price: Decimal(70.00)),
            Product(id: "004", category: .suspension, name: "Shock Mount", SKU: "S000", price: Decimal(90.00)),
            Product(id: "005", category: .suspension, name: "Bushing", SKU: "S111", price: Decimal(40.00))
        ]
    }

    func testApplyDiscountToCart() {
        addMockProducts()
        discounter.apply(discount: 10, toCart: cart)

        XCTAssertEqual(cart.products[0].price, Decimal(135.00))
        XCTAssertEqual(cart.products[1].price, Decimal(72.00))
        XCTAssertEqual(cart.products[2].price, Decimal(63.00))
        XCTAssertEqual(cart.products[3].price, Decimal(81.00))
        XCTAssertEqual(cart.products[4].price, Decimal(36.00))
    }

    func testApplyDiscountToProduct() {
        
        let product = Product(id: "006", category: .interior, name: "Seat Cover", SKU: "I123", price: Decimal(60.00))
        discounter.apply(discount: 15, toProduct: product)

        XCTAssertEqual(product.price, Decimal(51.00)) 
    }

    func testDiscountAppliedOncePerProduct() {
        
        addMockProducts()
        discounter.apply(discount: 10, toCart: cart)
        discounter.apply(discount: 20, toCart: cart)

        XCTAssertEqual(cart.products[0].price, Decimal(135.00))
        XCTAssertEqual(cart.products[1].price, Decimal(72.00))
        XCTAssertEqual(cart.products[2].price, Decimal(63.00))
        XCTAssertEqual(cart.products[3].price, Decimal(81.00))
        XCTAssertEqual(cart.products[4].price, Decimal(36.00))
    }

    func testApplyBuyTwoGetOneFreeSetsPriceCorrectly() {
        
        cart = ShoppingCart(products: [
            Product(id: "001", category: .suspension, name: "Shock Absorber", SKU: "S123", price: Decimal(150.00)),
            Product(id: "002", category: .suspension, name: "Spring", SKU: "S456", price: Decimal(70.00)),
            Product(id: "003", category: .suspension, name: "Shock Mount", SKU: "S789", price: Decimal(90.00)),
            Product(id: "004", category: .suspension, name: "Bushing", SKU: "S012", price: Decimal(40.00))
        ])

        discounter.applyBuyTwoGetOneFree(to: cart, for: .suspension)

        XCTAssertEqual(cart.products.first(where: { $0.id == "001" })?.price, Decimal(150.00))
        XCTAssertEqual(cart.products.first(where: { $0.id == "002" })?.price, Decimal(70.00))
        XCTAssertEqual(cart.products.first(where: { $0.id == "003" })?.price, Decimal(0.00)) // free item
        XCTAssertEqual(cart.products.first(where: { $0.id == "004" })?.price, Decimal(40.00))
    }

    func testApplyComboDeal() {
        
        cart = ShoppingCart(products: [.mockProduct1, .mockProduct2])
        let promotion = Promotion(name: "Combo Deal", requiredItems: [.mockProduct1, .mockProduct2], setPrice: Decimal(200.00))
        discounter.applyComboDeal(to: cart, for: promotion)

        XCTAssertEqual(cart.products[0].price, Decimal(100.00))
        XCTAssertEqual(cart.products[1].price, Decimal(100.00))
    }

    func testApplyComboDealWithDiscounts() {

        cart = ShoppingCart(products: [.mockProduct1, .mockProduct2])
        let promotion = Promotion(name: "Combo Deal", requiredItems: [.mockProduct1, .mockProduct2], setPrice: Decimal(200.00))
                
        discounter.applyComboDeal(to: cart, for: promotion)
        
        discounter.apply(discount: 10, toCart: cart)

        XCTAssertEqual(cart.products.first(where: { $0.id == "001" })?.price, Decimal(100.00))
        XCTAssertEqual(cart.products.first(where: { $0.id == "002" })?.price, Decimal(100.00))
    }
}

extension Product {
    
    static let mockProduct1 = Product(
        id: "001",
        category: .suspension,
        name: "Shock Absorber",
        SKU: "SHK123",
        price: 199.99
    )

    static let mockProduct2 = Product(
        id: "002",
        category: .exhaust,
        name: "Performance Muffler",
        SKU: "PMF456",
        price: 299.99
    )

    static let mockProduct3 = Product(
        id: "003",
        category: .transmission,
        name: "Clutch Kit",
        SKU: "CLT789",
        price: 349.99
    )

    static let mockProduct4 = Product(
        id: "004",
        category: .interior,
        name: "Leather Seat Covers",
        SKU: "LSC012",
        price: 149.99
    )

    static let mockProduct5 = Product(
        id: "005",
        category: .interior,
        name: "Floor Mats",
        SKU: "FM345",
        price: 59.99
    )
}
