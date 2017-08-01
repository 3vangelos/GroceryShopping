//
//  GroceryShoppingTests.swift
//  GroceryShoppingTests
//
//  Created by Sismanidis, Evangelos (415) on 01.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import XCTest
@testable import GroceryShopping

class GroceryShoppingTests: XCTestCase {
    
    private var viewModel = GroceriesViewModel()
    
    override func setUp() {
        super.setUp()
        // mock ExchangeRates
        viewModel.changeRates = ["USD": 1.0, "EUR": 2.0]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddGroceryToCart() {
        viewModel.addToGroceryAtIndex(0, amount: 1)
        XCTAssertTrue(viewModel.groceriesArray[0].amount == 1)
    }
    
    func testRemoveGroceryFromCart() {
        viewModel.addToGroceryAtIndex(1, amount: 1)
        viewModel.addToGroceryAtIndex(1, amount: 1)
        viewModel.addToGroceryAtIndex(1, amount: -1)
        XCTAssertTrue(viewModel.groceriesArray[1].amount == 1)
    }
    
    func testRemoveGroceryFromCartWhen0() {
        viewModel.addToGroceryAtIndex(2, amount: -1)
        XCTAssertTrue(viewModel.groceriesArray[2].amount == 0)
    }
    
    func testTotalCostsInUSD() {
        viewModel.addToGroceryAtIndex(0, amount: 1)
        viewModel.addToGroceryAtIndex(1, amount: 1)
        viewModel.addToGroceryAtIndex(2, amount: 1)
        let calculatedTotal = viewModel.totalCosts("USD")
        let sumTotal = viewModel.groceriesArray[0].cost
            + viewModel.groceriesArray[1].cost
            + viewModel.groceriesArray[2].cost
        XCTAssertEqual(calculatedTotal, sumTotal, accuracy: 0.001)
    }
    
    func testTotalCostsCurrencyComparisson() {
        viewModel.addToGroceryAtIndex(0, amount: 1)
        viewModel.addToGroceryAtIndex(1, amount: 1)
        viewModel.addToGroceryAtIndex(2, amount: 1)
        let totalUSDs = viewModel.totalCosts("USD")
        let totalEURs = viewModel.totalCosts("EUR")
        XCTAssertEqual(2.0 * totalUSDs, totalEURs, accuracy: 0.001)
    }
}
