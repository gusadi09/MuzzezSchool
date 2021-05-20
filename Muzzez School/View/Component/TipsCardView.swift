//
//  TipsCardView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct TipsCardView: View {
    var title = "Build an app with SwiftUI"
    var image = "guitarImg"
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .frame(width: 220, height: 180)
            Color(.black)
                .frame(width: 220, height: 180)
                .opacity(0.20)
            
            VStack {
                Spacer()
                
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(10)
                    .padding(.bottom, 15)
            }
        }
        .frame(width: 220, height: 180)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0.0, y: 4)
        //.shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 4)
    }
}

struct TipsCardView_Previews: PreviewProvider {
    static var previews: some View {
        TipsCardView()
    }
}
