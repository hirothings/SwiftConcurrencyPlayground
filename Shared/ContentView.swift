//
//  ContentView.swift
//  Shared
//
//  Created by hirothings on 2022/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("asyncな非同期処理") {
                    Sample1()
                }
                NavigationLink("asyncな非同期処理の連結(直列)") {
                    Sample2()
                }
                NavigationLink("async let: 並行処理（固定個数の場合）") {
                    Sample3()
                }
                NavigationLink("TaskGroup: 並行処理（可変個数の場合）") {
                    Sample4()
                }
                NavigationLink("RxSwiftとの連携") {
                    Sample5()
                }
                NavigationLink("コールバック関数をawaitする") {
                    Sample6()
                }
                NavigationLink("Delegateメソッドをawaitする") {
                    Sample7()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
