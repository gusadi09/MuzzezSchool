//
//  StoreManager.swift
//  Muzzez School
//
//  Created by Gus Adi on 04/06/21.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
  
  @Published var myProducts: SKProduct?
  
  var request: SKProductsRequest!
  @Published var transactionState: SKPaymentTransactionState?

  
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print("Did receive response")
    
    if !response.products.isEmpty {
      for fetchedProduct in response.products {
        DispatchQueue.main.async {
          self.myProducts = fetchedProduct
        }
      }
    }
    
    for invalidIdentifier in response.invalidProductIdentifiers {
      print("Invalid identifiers found: \(invalidIdentifier)")
    }
  }
  
  func getProducts(productIDs: String) {
    print("Start requesting products ...")
    let request = SKProductsRequest(productIdentifiers: Set(arrayLiteral: productIDs))
    request.delegate = self
    request.start()
  }
  
  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Request did fail: \(error)")
  }
  
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
        case .purchasing:
          self.transactionState = .purchasing
        case .purchased:
          UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
          queue.finishTransaction(transaction)
          self.transactionState = .purchased
        case .restored:
          UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
          queue.finishTransaction(transaction)
          self.transactionState = .restored
        case .failed, .deferred:
          UserDefaults.standard.setValue(false, forKey: transaction.payment.productIdentifier)
          print("Payment Queue Error: \(String(describing: transaction.error))")
          queue.finishTransaction(transaction)
          self.transactionState = .failed
        default:
          queue.finishTransaction(transaction)
      }
    }
  }
  
  func purchaseProduct(product: SKProduct) {
    if SKPaymentQueue.canMakePayments() {
      let payment = SKPayment(product: product)
      SKPaymentQueue.default().add(payment)
    } else {
      print("User can't make payment.")
    }
  }
}

extension SKProduct {
  var localizedPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = priceLocale
    return formatter.string(from: price)!
  }
}
