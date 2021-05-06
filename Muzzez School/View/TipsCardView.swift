//
//  TipsCardView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct TipsCardView: View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(20)
                .lineLimit(5)
            
            HStack {
                Spacer()
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }.padding(.bottom, 25)
        }
        .background(color)
        .cornerRadius(30)

    }
}

struct TipsCardView_Previews: PreviewProvider {
    static var previews: some View {
        TipsCardView()
    }
}
