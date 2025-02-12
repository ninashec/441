//
//  ChattListRow.swift
//  swiftUIChatter
//
//  Created by Nina Sheckler on 1/25/25.
//
import SwiftUI

struct ChattListRow: View {
    @Environment(AudioPlayer.self) private var audioPlayer
    @State private var isPresenting = false
    let chatt: Chatt
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                            if let message = chatt.message {
                                Text(message).padding(EdgeInsets(top: 8, leading: 0, bottom: 6, trailing: 0))
                            }
                            Spacer()
                            if let audio = chatt.audio {
                                Button {
                                    audioPlayer.setupPlayer(audio)
                                    isPresenting.toggle()
                                } label: {
                                    Image(systemName: "recordingtape").scaleEffect(1.5)
                                }
                                .fullScreenCover(isPresented: $isPresenting) {
                                    AudioView(isPresented: $isPresenting, autoPlay: true)
                                }
                            }
                        }
            if let message = chatt.message {
                            Text(message).padding(EdgeInsets(top: 8, leading: 0, bottom: 6, trailing: 0))
                        }
        }
    }
}
