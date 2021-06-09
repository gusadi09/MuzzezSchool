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
        
        let db = Firestore.firestore()
        
        let dataRef = db.collection("courses").document("\(self.sut.data[0].id)")
        var kurs = [[String: Any]]()
        
        if self.sut.data[0].isWishlist {
            dataRef.updateData([
                "isWishlist" : self.sut.data[0].isWishlist
            ])
            
            for i in self.sut.data[0].kurikulum {
                let kur = [
                    "title" : i.title,
                    "done" : i.done,
                    "videourl": i.videourl
                ] as [String : Any]
                
                kurs.append(kur)
            }
            
            db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(self.sut.data[0].id)").setData([
                "id": self.sut.data[0].id,
                "nama": self.sut.data[0].nama,
                "image": self.sut.data[0].image,
                "harga": self.sut.data[0].harga,
                "rating": self.sut.data[0].rating,
                "deskripsi": self.sut.data[0].deskripsi,
                "isWishlist" : self.sut.data[0].isWishlist,
                "kurikulum": kurs
            ])
        } else {
            dataRef.updateData([
                "isWishlist" : self.sut.data[0].isWishlist
            ])
            
            db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(self.sut.data[0].id)").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        
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
            
            
            let db = Firestore.firestore()
            
            let dataRef = db.collection("courses").document("\(self.sut.data[0].id)")
            var kurs = [[String: Any]]()
            
            if self.sut.data[0].isWishlist {
                dataRef.updateData([
                    "isWishlist" : self.sut.data[0].isWishlist
                ])
                
                for i in self.sut.data[0].kurikulum {
                    let kur = [
                        "title" : i.title,
                        "done" : i.done,
                        "videourl": i.videourl
                    ] as [String : Any]
                    
                    kurs.append(kur)
                }
                
                db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(self.sut.data[0].id)").setData([
                    "id": self.sut.data[0].id,
                    "nama": self.sut.data[0].nama,
                    "image": self.sut.data[0].image,
                    "harga": self.sut.data[0].harga,
                    "rating": self.sut.data[0].rating,
                    "deskripsi": self.sut.data[0].deskripsi,
                    "isWishlist" : self.sut.data[0].isWishlist,
                    "kurikulum": kurs
                ])
            } else {
                dataRef.updateData([
                    "isWishlist" : self.sut.data[0].isWishlist
                ])
                
                db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(self.sut.data[0].id)").delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
            
            self.sut.fetchData()
            let course = sut.data.first!
            XCTAssertEqual(course.id, 1)
            exp.fulfill()
            
            self.waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
}
