//
//  APIClient.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/09.
//

import Foundation

struct Item<T>: Decodable where T: Decodable {
    let contents: [T]
}

struct User: Identifiable, Decodable {
    let id: String
    let name: String
    let age: Int
    let gender: Gender
}

enum Gender: String, Decodable {
    case man
    case woman
}

struct News: Identifiable, Decodable {
    let id: String
    let title: String
    let authorId: String
}

struct Icon: Identifiable, Decodable {
    let id: String
    let userId: String
    let iconUrl: IconUrl
    
    struct IconUrl: Decodable {
        let url: String
    }
}

struct APIClient {
    static func fetchUsers() async throws -> [User] {
        let url = URL(string: "https://qehzqb2qqs.microcms.io/api/v1/users")!
        let request = makeRequest(url)
        let result = try await URLSession.shared.data(for: request)
        let users = try JSONDecoder().decode(Item<User>.self, from: result.0)
        return users.contents
    }
    
    static func fetchUser(by id: String) async throws -> User {
        let url = URL(string: "https://qehzqb2qqs.microcms.io/api/v1/users?filters=id[equals]\(id)")!
        let request = makeRequest(url)
        let result = try await URLSession.shared.data(for: request)
        let users = try JSONDecoder().decode(Item<User>.self, from: result.0)
        return users.contents.first!
    }
    
    static func fetchNews() async throws -> [News] {
        let url = URL(string: "https://qehzqb2qqs.microcms.io/api/v1/news")!
        let request = makeRequest(url)
        let result = try await URLSession.shared.data(for: request)
        let news = try JSONDecoder().decode(Item<News>.self, from: result.0)
        return news.contents
    }
    
    static func fetchNews(by authorId: String) async throws -> [News] {
        let url = URL(string: "https://qehzqb2qqs.microcms.io/api/v1/news?filters=authorId[equals]\(authorId)")!
        let request = makeRequest(url)
        let result = try await URLSession.shared.data(for: request)
        let news = try JSONDecoder().decode(Item<News>.self, from: result.0)
        return news.contents
    }
    
    static func fetchIcon(by userId: String) async throws -> Icon {
        print("アイコン取得開始: \(userId)")
        let url = URL(string: "https://qehzqb2qqs.microcms.io/api/v1/user-icons?filters=userId[equals]\(userId)")!
        let request = makeRequest(url)
        let result = try await URLSession.shared.data(for: request)
        let icons = try JSONDecoder().decode(Item<Icon>.self, from: result.0)
        print("アイコン取得完了: \(userId)")

        return icons.contents.first!
    }
    
    private static func makeRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("{API Key}", forHTTPHeaderField: "X-MICROCMS-API-KEY")
        return request
    }
}
