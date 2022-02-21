//
//  Challenge1.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/21.
//

import SwiftUI

// 問題1:
// ユーザー一覧と、ニュース一覧をListで表示してください
// 非同期処理は並列に行なってください
struct Challenge1: View {
    @State private var users: [User] = []
    @State private var news: [News] = []
    
    var body: some View {
        Button("fetch users and news") {
            // ここに処理を書く
        }
        HStack {
            List(users) { user in
                Text(user.name)
            }
            List(news) { news in
                Text(news.title)
            }
        }
    }
}
