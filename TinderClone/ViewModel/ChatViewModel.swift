import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable> ()
    @Published var chat: Chat
    @Published var isLoading = false
    @Published var messages = [Message]()
    
    init(chat: Chat) {
        self.chat = chat
        setupSubscribers()
        Task {
            try await fetchMessages()
        }
    }
    
    func setupSubscribers() {
        AuthService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
    
    func sendReply(reply: String) {
        if let currentUser = currentUser {
            ChatService.onReply(chatId: chat.id, userId: currentUser.id, reply: reply)
        }
    }
    
    @MainActor
    private func fetchMessages() async throws {
        isLoading = true
        ChatService.fetchMessages(chatId: chat.id) { messages in
            self.messages = messages
            self.isLoading = false
        }
    }
}
