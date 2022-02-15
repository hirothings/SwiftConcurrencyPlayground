//
//  Sample3.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/09.
//

import SwiftUI

struct Sample3: View {
    @State private var result: (user: User, icon: Icon)?
    
    var body: some View {
        Button("fetch user with icon") {
            Task {
                let userId = "k584y19qe"
                async let user = APIClient.fetchUser(by: userId)
                async let icon = APIClient.fetchIcon(by: userId)
                result = try! await (user: user, icon: icon)
            }
        }
        if let result = result {
            Text("ユーザー名: \(result.user.name)")
            AsyncImage(url: URL(string: result.icon.iconUrl.url)!)
        }
    }
}
