//
//  SearchBar.swift
//  Muzzez School
//
//  Created by Gus Adi on 07/06/21.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewRepresentable {
  
  @Binding var text: String
  
  class Coordinator: NSObject, UISearchBarDelegate {
    
    @Binding var text: String
    
    init(text: Binding<String>) {
      _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      text = searchText
    }
  }
  
  func makeCoordinator() -> SearchBar.Coordinator {
    return Coordinator(text: $text)
  }
  
  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Cari course..."
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    uiView.text = text
  }
}

