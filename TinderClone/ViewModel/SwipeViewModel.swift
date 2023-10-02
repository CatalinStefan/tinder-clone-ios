import Foundation
import Combine

@MainActor
class SwipeViewModel: ObservableObject {
    private var currentUser: User?
    private var cancellable = Set<AnyCancellable> ()
    @Published var potentialCards: [Card] = []
    @Published var isLoading = false
    
    init() {
        setupSubscribers()
        Task {
            try await fetchPotentialUsers()
        }
    }
    
    func setupSubscribers() {
        AuthService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellable)
    }
    
    @MainActor
    private func fetchPotentialUsers() async throws {
        if let currentUser = currentUser {
            isLoading = true
            let potentialUsers = try await UserService.fetchSwipeCardUsers(user: currentUser)
            potentialCards = Card.fromUsers(withUsers: potentialUsers)
            isLoading = false
        }
    }
    
    func onDislike(dislikeCard: Card) async {
        if let currentUser = currentUser {
            potentialCards.removeAll { card in
                card.id == dislikeCard.id
            }
            UserService.onDislike(user1: currentUser, user2: dislikeCard.user)
        }
    }
    
    func onLike(likeCard: Card, onMatch: () -> ()) async {
        if let currentUser = currentUser {
            potentialCards.removeAll { card in
                card.id == likeCard.id
            }
            UserService.onLike(user1: currentUser, user2: likeCard.user) {
                print("DEBUG: Match!")
                onMatch()
            }
        }
    }
}
