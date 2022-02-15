//
//  Sample6.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/10.
//

import SwiftUI

class Sample6ViewModel {
    func fetchUser() async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            fetchUser { result in
                continuation.resume(with: result)
            }
        }
    }
    
    private func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(.success(
                User(id: "1", name: "hiroshi", age: 34, gender: .man)
            ))
        }
    }
}

struct Sample6: View {
    @State private var user: User?
    private let viewModel = Sample6ViewModel()
    
    var body: some View {
        Button("fetch user") {
            Task {
                user = try! await viewModel.fetchUser()
            }
        }
        if let user = user {
            Text("user: \(user.name)")
        }
    }
}
