//
//  Indicator.swift
//  FootbalTeams
//
//  Created by Gus Adi on 14/05/21.
//

import Foundation
import UIKit
import SwiftUI

struct Indicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indi = UIActivityIndicatorView(style: .large)
        
        return indi
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
