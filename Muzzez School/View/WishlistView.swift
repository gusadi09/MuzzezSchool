//
//  WishlistView.swift
//  Muzzez School
//
//  Created by Gus Adi on 02/06/21.
//

import SwiftUI

struct WishlistView: View {
  
  @ObservedObject var wishlistData = LoadDataUser()
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 25) {
          ForEach(wishlistData.data?.wishlist ?? [], id: \.id) { item in
            WishlistCard(item: item)
              .onTapGesture(perform: {
                DispatchQueue.main.async {
                  self.viewController?.present(style: .fullScreen, builder: {
                    CourseDetailView(item: item, loveIcon: item.isWishlist)
                      .ignoresSafeArea()
                  })
                }
              })
          }
        }
        
        .padding()
      }
  
      .navigationTitle("Wishlist")
    }
    .onAppear(perform: {
      self.wishlistData.fetchData()
    })
  }
}

struct WishlistView_Previews: PreviewProvider {
  static var previews: some View {
    WishlistView()
  }
}
