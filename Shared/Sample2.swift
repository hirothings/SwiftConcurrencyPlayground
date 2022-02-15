//
//  Sample2.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/09.
//

import SwiftUI

struct Sample2: View {
    @State private var user: User?
    @State private var news: [News] = []
    
    var body: some View {
        Button("fetch news") {
            Task {
                let user = try! await APIClient.fetchUsers().first!
                self.user = user
                news = try! await APIClient.fetchNews(by: user.id)
            }
        }
        if let user = user {
            Text("\(user.name)の記事")
        }
        ForEach(news) { news in
            Text("\(news.title)")
        }
    }
}
