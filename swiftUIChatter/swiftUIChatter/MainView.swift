//
//  MainView.swift
//  swiftUIChatter
//
//  Created by Nina Sheckler on 1/25/25.
//


import SwiftUI

struct MainView: View {
    private let store = ChattStore.shared
    @State private var isPresenting = false
    var body: some View {
        List(store.chatts) {
            ChattListRow(chatt: $0)
                .listRowSeparator(.hidden)
                .listRowBackground(Color($0.altRow ?
                    .systemGray5 : .systemGray6))
        }
        .listStyle(.plain)
        .refreshable {
                        store.getChatts()
                    }
        .navigationTitle("Chatter")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement:.topBarTrailing) {
                            Button {
                                isPresenting.toggle()
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                    .navigationDestination(isPresented: $isPresenting) {
                        PostView(isPresented: $isPresenting)
                    }    
    }
}
