//
//  SearchView.swift
//  Muzzez School
//
//  Created by Gus Adi on 07/06/21.
//

import SwiftUI

struct SearchView: View {
  
  @State private var searchText = ""
  @ObservedObject var dataCourse = LoadDataCourse()
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView {
      VStack {
        SearchBar(text: $searchText)
          .padding(.top)
        
        if searchText.isEmpty {
          VStack {
            Spacer()
            Image("searchEmpty")
              .resizable()
              .frame(width: 200, height: 131.94, alignment: .center)
              .padding()
            Text("Temukan Kursus")
              .font(.title2)
              .fontWeight(.bold)
            
            Text("Coba temukan kursus baru dengan pencarian.")
              .frame(width: 300, height: 100, alignment: .center)
              .multilineTextAlignment(.center)
            Spacer()
          }
          Spacer()
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(dataCourse.data.filter({ searchText.isEmpty ? true : $0.nama.localizedStandardContains(searchText) })) { item in
              SearchCard(item: item, harga: item.harga)
                .padding(.horizontal)
                .padding(.bottom)
                .onTapGesture(perform: {
                  DispatchQueue.main.async {
                    self.viewController?.present(style: .fullScreen, builder: {
                      CourseDetailView(item: item, harga: item.harga, loveIcon: item.isWishlist)
                        .ignoresSafeArea()
                    })
                    
                  }
                })
            }
            Spacer()
          }
        }
      }
      
      
      .navigationTitle(Text("Search"))
    }
    .onAppear(perform: {
      self.dataCourse.fetchData()
    })
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
