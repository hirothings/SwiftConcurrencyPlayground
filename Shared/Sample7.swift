//
//  Sample7.swift
//  SwiftConcurrencyPlayground
//
//  Created by hirothings on 2022/02/10.
//

import SwiftUI

// note: 必ず1回しか呼ばれないDelegateの場合しか使えない
// CheckedContinuationのresumeメソッドは1回だけしか呼べないため

protocol TimerDelegate: AnyObject {
    func timeup(_ message: String)
    func timeup(with error: Error)
}

class TimerManager {
    weak var delegate: TimerDelegate? = nil
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.delegate?.timeup("timeup!")
        }
    }
}

class Sample7ViewModel: TimerDelegate  {
    private let timerManager = TimerManager()
    private var activeContinuation: CheckedContinuation<String, Error>?
    
    init() {
        timerManager.delegate = self
    }
    
    func waitTimer() async throws -> String {
        try await withCheckedThrowingContinuation({ continuation in
            activeContinuation = continuation
            timerManager.startTimer()
        })
    }
    
    func timeup(_ message: String) {
        activeContinuation?.resume(returning: message)
        // 1回しかresumeメソッドを呼べないので、明示的にnilを代入する
        activeContinuation = nil
    }
    
    func timeup(with error: Error) {
        activeContinuation?.resume(throwing: error)
        // 1回しかresumeメソッドを呼べないので、明示的にnilを代入する
        activeContinuation = nil
    }
}

struct Sample7: View {
    @State private var message: String = ""
    private let viewModel = Sample7ViewModel()
    
    var body: some View {
        Button("Wait Timer") {
            Task {
                message = try! await viewModel.waitTimer()
            }
        }
        Text(message)
    }
}
