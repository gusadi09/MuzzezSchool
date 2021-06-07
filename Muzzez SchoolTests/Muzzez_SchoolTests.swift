//
//  Muzzez_SchoolTests.swift
//  Muzzez SchoolTests
//
//  Created by Gus Adi on 07/06/21.
//

import XCTest
import Firebase
@testable import Muzzez_School

class Muzzez_SchoolTests: XCTestCase {
  var sut: LoadDataCourse!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try super.setUpWithError()
    sut = LoadDataCourse()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    sut = nil
    try super.tearDownWithError()
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    self.sut.data = [Courses(id: 1, nama: "test", image: "test", harga: "test", rating: 0.0, deskripsi: "test", complete: false, isBuy: false, isWishlist: false, kurikulum: [])]
    
    let exp = self.expectation(description: "waiting for async operation")
    
    WriteDataService().writeWishlist(kurikulum: self.sut.data[0].kurikulum, id: self.sut.data[0].id, isLove: self.sut.data[0].isWishlist, nama: self.sut.data[0].nama, image: self.sut.data[0].image, price: self.sut.data[0].harga, rate: self.sut.data[0].rating, desc: self.sut.data[0].deskripsi)
    
    self.sut.fetchData()
    let course = sut.data.first!
    XCTAssertEqual(course.id, 1)
    exp.fulfill()
    
    self.waitForExpectations(timeout: 10, handler: nil)
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
      self.sut.data = [Courses(id: 1, nama: "test", image: "test", harga: "test", rating: 0.0, deskripsi: "test", complete: false, isBuy: false, isWishlist: false, kurikulum: [])]
      
      let exp = self.expectation(description: "waiting for async operation")
      
      WriteDataService().writeWishlist(kurikulum: self.sut.data[0].kurikulum, id: self.sut.data[0].id, isLove: self.sut.data[0].isWishlist, nama: self.sut.data[0].nama, image: self.sut.data[0].image, price: self.sut.data[0].harga, rate: self.sut.data[0].rating, desc: self.sut.data[0].deskripsi)
      
      self.sut.fetchData()
      let course = sut.data.first!
      XCTAssertEqual(course.id, 1)
      exp.fulfill()
      
      self.waitForExpectations(timeout: 10, handler: nil)
    }
  }
  
}
