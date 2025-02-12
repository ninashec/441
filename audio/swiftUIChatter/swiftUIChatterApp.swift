//
//  swiftUIChatterApp.swift
//  swiftUIChatter
//
//  Created by Nina Sheckler on 1/25/25.
//

import SwiftUI

@main
struct swiftUIChatterApp: App {
    init() {
           ChattStore.shared.getChatts()
       }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                            MainView()
                        }
                        .environment(AudioPlayer())

        }
    }
}
