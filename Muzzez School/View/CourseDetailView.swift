//
//  ContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct CourseDetailView: View {
  
  @State var show = false
  @State var viewState = CGSize.zero
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    ZStack {
      BlurView(style: .systemMaterial)
      
      VStack {
        HStack {
          Button(action: {
            self.viewController?.dismiss(animated: true, completion: nil)
          }, label: {
            
            Image(systemName: "chevron.left")
              .padding()
              .background(Color(.white))
              .foregroundColor(.black)
              .cornerRadius(10)
              .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.0, y: 4)
          })
          
          Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 60)
        
        TitleView(text: "Course Detail")
          .blur(radius: show ? 20 : 0)
          .animation(.default)
        
        Spacer()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    CourseDetailView()
  }
}

struct TitleView: View {
  var text: String = "Course Detail"
  var body: some View {
    return VStack {
      HStack {
        Text(text)
          .font(.largeTitle)
          .fontWeight(.heavy)
        Spacer()
      }.foregroundColor(.black)
    }.padding(.horizontal)
    .padding(.top)
    .padding(.bottom, 10)
  }
}
