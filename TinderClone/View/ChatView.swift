import SwiftUI

struct ChatView: View {
    @EnvironmentObject var viewModel: ChatViewModel
    @State private var reply = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        let currentUserId = viewModel.currentUser?.id
        let otherUser = viewModel.chat.user1.id == currentUserId ? viewModel.chat.user2 : viewModel.chat.user1
        
        VStack {
            // header
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(.leading)
                    .foregroundColor(.blue)
                NavigationLink(value: otherUser) {
                    RoundImageView(imageUrl: otherUser.profileImageUrl, imageSize: .small)
                        .padding()
                }
                Text(otherUser.name)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .background(.white)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 0)
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            
            // messages
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack {
                        ForEach(viewModel.messages) { message in
                            if currentUserId == message.sentBy {
                                Spacer()
                                Text(message.text)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .frame(maxWidth: 300, alignment: .trailing)
                            } else {
                                Text(message.text)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                    .padding(12)
                                    .background(Color(.systemGray5))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .frame(maxWidth: 300, alignment: .leading)
                                Spacer()
                            }
                        }
                    }
                    .id("MessageScrollView")
                }
                .onChange(of: viewModel.messages.count) { _ in
                    scrollView.scrollTo("MessageScrollView", anchor: .bottom)
                }
            }
            .padding(0)
            
            // send reply
            HStack(alignment: .bottom) {
                TextField("Type a message...", text: $reply, axis: .vertical)
                    .lineLimit(4)
                Text("SEND")
                    .foregroundColor(reply.isEmpty ? .gray : .blue)
                    .onTapGesture {
                        if !reply.isEmpty {
                            viewModel.sendReply(reply: reply)
                            reply = ""
                        }
                    }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black, lineWidth: 1)
            )
            .padding()
        }
        .statusBarHidden()
        .navigationBarBackButtonHidden()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ChatViewModel(chat: Chat(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[1])))
    }
}
