import Foundation
import FirebaseFirestore

struct ChatService {
    static func onReply(chatId: String, userId: String, reply: String) {
        let r = Message(sentBy: userId, text: reply, timestamp: Timestamp())
        guard let encodedR = try? Firestore.Encoder().encode(r) else { return }
        Firestore.firestore()
            .collection(COLLECTION_CHAT)
            .document(chatId)
            .collection(COLLECTION_MESSAGES)
            .document()
            .setData(encodedR)
    }
    
    @MainActor
    static func fetchMessages(chatId: String, onMessagesUpdate: @escaping ([Message]) -> ()) {
        Firestore.firestore()
            .collection(COLLECTION_CHAT)
            .document(chatId)
            .collection(COLLECTION_MESSAGES)
            .order(by: "timestamp")
            .addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    do {
                        let messages = try snapshot.documents.compactMap({ try $0.data(as: Message.self) })
                        onMessagesUpdate(messages)
                    } catch {
                        print("DEBUG: message conversion failed")
                    }
                }
            }
    }
}
