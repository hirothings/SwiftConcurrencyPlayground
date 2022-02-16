//
//  Sample8.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/16.
//

import SwiftUI

struct Sample8: View {
    var body: some View {
        Button("group.next()") {
            /// 次の子タスク(fast)しかawaitしない
            /// すべての処理が実行される
            Task {
                await withTaskGroup(of: Void.self) { group in
                    group.addTask { await fast() }
                    group.addTask { await slow() }
                    print("""
                    ---
                    group.next()
                    ---
                    """)
                    await group.next()
                    print("awaited?")
                }
            }
        }
        Spacer().frame(height: 16)
        Button("group.waitForAll()") {
            /// すべての処理をawaitする
            Task {
                await withTaskGroup(of: Void.self) { group in
                    group.addTask { await fast() }
                    group.addTask { await slow() }
                    print("""
                    ---
                    group.waitForAll()
                    ---
                    """)
                    await group.waitForAll()
                    print("awaited?")
                }
            }
        }
    }

    func fast() async {
        await withCheckedContinuation { continuation in
            fast { _ in
                continuation.resume()
            }
        }
    }

    func slow() async {
        await withCheckedContinuation { continuation in
            slow { _ in
                continuation.resume()
            }
        }
    }

    private func fast(completion: @escaping (Result<Void, Error>) -> Void) {
        print("fast")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            print("fast -- done")
            completion(.success(()))
        }
    }

    private func slow(completion: @escaping (Result<Void, Error>) -> Void) {
        print("slow")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            print("slow -- done")
            completion(.success(()))
        }
    }
}
