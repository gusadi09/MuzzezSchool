//
//  DetailView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct DetailView: View {
    @State var show = false
    @State var viewState = CGSize.zero

    var body: some View {
       ZStack {
          BlurView(style: .systemMaterial)

          TitleView(text: "Tips Detail")
             .blur(radius: show ? 20 : 0)
             .animation(.default)

          
       }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
