//
//  Sample5.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/10.
//

import SwiftUI
import RxSwift

struct Sample5: View {
    @State private var singleValue: Int = 0
    @State private var values: [String] = []
    
    var body: some View {
        Button("Single") {
            Task {
                let single = Single.just(1)
                singleValue = try! await single.value
            }
        }
        Text("singleValue: \(singleValue)")
        Button("Observable") {
            Task {
                let observable = Observable.from(["ひ", "ろ", "し"])
                // observableがcompleteしない場合、非同期タスクが一時停止して親タスクに戻らない
                for try await value in observable.values {
                    values.append(value)
                }
            }
        }
        ForEach(values, id: \.self) { value in
            Text(value)
        }
    }
}
