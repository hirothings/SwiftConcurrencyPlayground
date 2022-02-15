//
//  Sample4.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/10.
//

import SwiftUI

struct Sample4: View {
    @State private var icons: [String: String] = [:]
    
    var body: some View {
        Button("fetch users") {
            Task {
                let ids = try! await APIClient.fetchUsers().map { $0.id }
                icons = try! await fetchUserIcons(ids: ids)
            }
        }
        ForEach(icons.sorted(by: >), id: \.key) { id, url in
            HStack {
                Text("ユーザーID: \(id)")
                AsyncImage(url: URL(string: url)!) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 62, height: 62)
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    func fetchUserIcons(ids: [String]) async throws -> [String: String] {
        try await withThrowingTaskGroup(of: (String, Icon).self) { group in
            for id in ids {
                group.addTask {
                    return try await (id, APIClient.fetchIcon(by: id))
                }
            }
            var icons: [String: String] = [:]
            for try await (id, icon) in group {
                icons[id] = icon.iconUrl.url
            }
            return icons
        }
    }
}
