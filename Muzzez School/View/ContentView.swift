//
//  ContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct ContentView: View {

   @State var show = false
   @State var viewState = CGSize.zero

   var body: some View {
      ZStack {
         BlurView(style: .systemMaterial)

         TitleView(text: "Course Detail")
            .blur(radius: show ? 20 : 0)
            .animation(.default)

         
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
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

         Spacer()
      }.padding()
   }
}
