//
//  CourseView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

/**
 Pada tampilan course view ini cukup simple. Jadi data yang terdapat pada storage firestore pada firebase di fetch dengan fungsi yang disediakan oleh google firebase
 
 Dan nantinya data yang sudah di fetch akan ditampilkan dengan tampilan list.
 **/

import SwiftUI

struct CourseView: View {
  
  @ObservedObject var courseData = LoadDataUser()
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(courseData.data?.course ?? [], id: \.id) { item in
            
            MyCourseCard(item: item)
              .onTapGesture {
                DispatchQueue.main.async {
                  self.viewController?.present(style: .fullScreen, builder: {
                    MyCourseDetailView(item: item)
                      .ignoresSafeArea()
                  })
                }
              }
            
          }
          .padding()
        }
      }
      
      .navigationTitle(Text("My Course"))
    }
    .onAppear {
      self.courseData.fetchData()
    }
  }
}

struct CourseView_Previews: PreviewProvider {
  static var previews: some View {
    CourseView()
  }
}
