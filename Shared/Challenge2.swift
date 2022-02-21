//
//  Challenge2.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/21.
//

import SwiftUI

struct UserNews: Identifiable {
    let id: String
    let news: [News]
}

// 問題2:
// ユーザーIDごとの、ニュース一覧をListで表示してください
// ニュースの取得処理は並列に行なってください

struct Challenge2: View {
    @State var userNews: [UserNews] = []
    
    var body: some View {
        Button("fetch news by user") {
            // ここに処理を書く
        }
        Form {
            ForEach(userNews) { userNews in
                Section(userNews.id) {
                    List(userNews.news) { news in
                        Text(news.title)
                    }
                }
            }
        }
    }
}
