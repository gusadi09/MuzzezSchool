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
    var body: some View {
        NavigationView {
            Text("Course")
                .navigationTitle("Course")
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
