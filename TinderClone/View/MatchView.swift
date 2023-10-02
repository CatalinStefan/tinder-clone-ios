import SwiftUI

struct MatchView: View {
    @StateObject var viewModel = MatchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.matches) { chat in
                            NavigationLink(value: chat) {
                                let otherUserName = chat.user1.id == viewModel.currentUser?.id ? chat.user2.name : chat.user1.name
                                let otherUserProfileImage = chat.user1.id == viewModel.currentUser?.id ? chat.user2.profileImageUrl : chat.user1.profileImageUrl
                                HStack {
                                    RoundImageView(imageUrl: otherUserProfileImage, imageSize: .medium)
                                    Text(otherUserName)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Matches")
                }
                
                if $viewModel.isLoading.wrappedValue {
                    LoadingOverlayView()
                }
            }
            .navigationDestination(for: Chat.self) { chat in
                ChatView()
                    .environmentObject(ChatViewModel(chat: chat))
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
