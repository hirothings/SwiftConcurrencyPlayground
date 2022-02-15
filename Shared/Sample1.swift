//
//  Sample1.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/08.
//

import SwiftUI

struct Sample1: View {
    @State private var users: [User] = []
    
    var body: some View {
        Button("fetch users") {
            Task {
                users = try! await APIClient.fetchUsers()
            }
        }
        ForEach(users) { user in
            Text("\(user.name): \(user.age)")
        }
    }
}
