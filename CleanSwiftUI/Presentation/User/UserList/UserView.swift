//
//  UserView.swift
//  CleanSwiftUI
//
//  Created by Tuan Truong on 03/11/2022.
//

import SwiftUI

struct UserView: View {
    // Init
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name)
                .bold()
            Text(user.birthday.formatted(date: .abbreviated, time: .omitted))
        }
        .badge(user.gender.title)
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
