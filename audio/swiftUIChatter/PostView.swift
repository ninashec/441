import SwiftUI

struct PostView: View {
    @Binding var isPresented: Bool
    @Environment(AudioPlayer.self) private var audioPlayer
    @State private var isPresenting = false
    @FocusState private var messageInFocus: Bool
    private let username = "ninashec"
    @State private var message = "Beep bop boop"
    
    var body: some View {
        VStack {
            
            Text(username)
                .padding(.top, 30.0)
            TextEditor(text: $message)
                .focused($messageInFocus)
                .padding(EdgeInsets(top: 10, leading: 18, bottom: 0, trailing: 4))
                .frame(minHeight: 80, maxHeight: 120)
                .navigationTitle("Post")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                            ToolbarItem(placement:.topBarTrailing) {
                                SubmitButton()
                            
                            }
                            ToolbarItem(placement: .bottomBar) {
                                    AudioButton(isPresenting: $isPresenting)
                                }
                        }
                .fullScreenCover(isPresented: $isPresenting) {
                            AudioView(isPresented: $isPresenting, autoPlay: false)
                        }
                        .onAppear {
                            audioPlayer.setupRecorder()
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            messageInFocus.toggle()
                        }
            Spacer().frame(maxHeight: .infinity)
            
        }
    }
    @ViewBuilder
        func SubmitButton() -> some View {
            @State var isDisabled: Bool = false
            
            Button {
                isDisabled = true
                ChattStore.shared.postChatt(Chatt(username: username, message: message, audio: audioPlayer.audio?.base64EncodedString())) {
                                ChattStore.shared.getChatts()
                            }
                isPresented.toggle()
            } label: {
                Image(systemName: "paperplane")
            }
            .disabled(isDisabled)
            .opacity(isDisabled ? 0.2 : 1)
        }
}

struct AudioButton: View {
    @Binding var isPresenting: Bool
    @Environment(AudioPlayer.self) private var audioPlayer

    var body: some View {
        Button {
            isPresenting.toggle()
        } label: {
            if let _ = audioPlayer.audio {
                Image(systemName: "mic.fill").padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)).scaleEffect(1.5).foregroundColor(Color(.systemRed))
            } else {
                Image(systemName: "mic").padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)).scaleEffect(1.5).foregroundColor(Color(.systemGreen))
            }
        }
    }
}
