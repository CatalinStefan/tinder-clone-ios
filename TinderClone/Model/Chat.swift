import Foundation

struct Chat: Identifiable, Codable, Hashable {
    let id: String
    let user1: User
    let user2: User
    
    static let mockChats: [Chat] = [
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[1]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[2]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[3]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[4]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[5]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[6]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[7]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[8]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[9]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[1]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[2]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[3]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[4]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[5]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[6]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[7]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[8]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[0], user2: User.mockUsers[9]),
    ]
}
