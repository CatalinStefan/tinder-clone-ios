import Foundation
import FirebaseFirestore

struct UserService {
    @MainActor
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore()
            .collection(COLLECTION_USER).document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    @MainActor
    static func fetchSwipeCardUsers(user: User) async throws -> [User] {
        // If the user preference is unspecified, then the potential user can have any gender
        // If the user preference is specific, the potential user can have only that specific gender
        // AND
        // Exclude our current user id
        // AND
        // Select users whose preference matches our gender
        // Select users whose preference is unspecified
        let query = Firestore.firestore().collection(COLLECTION_USER)
            .whereFilter(
                Filter.andFilter([
                    Filter.whereField("gender", in: user.preference == TinderGender.unspecified.rawValue ? [TinderGender.man.rawValue, TinderGender.woman.rawValue, TinderGender.unspecified.rawValue] : [user.preference]),
                    Filter.whereField("id", isNotEqualTo: user.id),
                    Filter.whereField("preference", in: [user.gender, TinderGender.unspecified.rawValue])
                ])
            )
        
        let snapshot = try await query.getDocuments()
        
        let docs = try snapshot.documents.compactMap({
            try $0.data(as: User.self)
        })
        
        let filteredDocs = docs.filter { potUser in
            if user.swipesLeft.contains(potUser.id) ||
                user.swipesRight.contains(potUser.id) ||
                user.matches.contains(potUser.id) {
                return false
            }
            return true
        }
        
        return filteredDocs
    }
    
    @MainActor
    static func onDislike(user1: User, user2: User) {
        Firestore.firestore().collection(COLLECTION_USER).document(user1.id)
            .updateData(["swipesLeft": FieldValue.arrayUnion([user2.id])])
    }
    
    @MainActor
    static func onLike(user1: User, user2: User, onMatch: () -> ()) {
        let match = user2.swipesRight.contains(user1.id)
        let u1 = Firestore.firestore().collection(COLLECTION_USER).document(user1.id)
        let u2 = Firestore.firestore().collection(COLLECTION_USER).document(user2.id)
        if !match {
            u1.updateData(["swipesRight": FieldValue.arrayUnion([user2.id])])
        } else {
            onMatch()
            u2.updateData(["swipesRight": FieldValue.arrayRemove([user1.id])])
            u1.updateData(["matches": FieldValue.arrayUnion([user2.id])])
            u2.updateData(["matches": FieldValue.arrayUnion([user1.id])])
            
            let chatKey = Firestore.firestore().collection(COLLECTION_CHAT).document().documentID
            let chatData = Chat(id: chatKey, user1: user1, user2: user2)
            guard let encodedChat = try? Firestore.Encoder().encode(chatData) else { return }
            Firestore.firestore().collection(COLLECTION_CHAT).document(chatKey).setData(encodedChat)
        }
    }
}
