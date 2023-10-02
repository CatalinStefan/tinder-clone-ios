import Foundation
import FirebaseFirestore

struct MatchService {
    @MainActor
    static func fetchMatches(userId: String, onMatchesUpdate: @escaping ([Chat]) -> ()) {
        Firestore.firestore().collection(COLLECTION_CHAT)
            .whereFilter(
                Filter.orFilter([
                    Filter.whereField("user1.id", isEqualTo: userId),
                    Filter.whereField("user2.id", isEqualTo: userId)
                ])
            )
            .addSnapshotListener { snapshot, error in
                do {
                    if let snapshot = snapshot {
                        let chats = try snapshot.documents.compactMap({ try $0.data(as: Chat.self) })
                        onMatchesUpdate(chats)
                    }
                } catch {
                    print("DEBUG: chat conversion failed")
                }
            }
    }
}
