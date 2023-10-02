import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let email: String
    let name: String
    var age: Int?
    var bio: String?
    var profileImageUrl: String?
    var gender: String = TinderGender.unspecified.rawValue
    var preference: String = TinderGender.unspecified.rawValue
    var interests: Array<String> = []
    var swipesLeft: Array<String> = []
    var swipesRight: Array<String> = []
    var matches: Array<String> = []
    
    static let mockUsers: [User] = [
        .init(id: NSUUID().uuidString, email: "alice@gmail.com", name: "Alice", age: 29, bio: "Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio Alice's bio ", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/tindercloneios-ca933.appspot.com/o/images%2F0CB9E8A4-E17E-48E2-9360-1EE3A83FF139?alt=media&token=2eb4299c-f02b-4bb6-908f-cc142af8216a",
             gender: "woman", preference: "man", interests: ["skiing", "bicycles", "painting", "astrology"]),
        .init(id: NSUUID().uuidString, email: "u2@gmail.com", name: "u2", age: 29, bio: "u2bio"),
        .init(id: NSUUID().uuidString, email: "u3@gmail.com", name: "u3", age: 29, bio: "u3bio", profileImageUrl: "ai_man3"),
        .init(id: NSUUID().uuidString, email: "u4@gmail.com", name: "u4", age: 29, bio: "u4bio", profileImageUrl: "ai_man4"),
        .init(id: NSUUID().uuidString, email: "u5@gmail.com", name: "u5", age: 29, bio: "u5bio", profileImageUrl: "ai_man5"),
        .init(id: NSUUID().uuidString, email: "u6@gmail.com", name: "u6", age: 29, bio: "u6bio", profileImageUrl: "ai_woman1"),
        .init(id: NSUUID().uuidString, email: "u7@gmail.com", name: "u7", age: 29, bio: "u7bio", profileImageUrl: "ai_woman2"),
        .init(id: NSUUID().uuidString, email: "u8@gmail.com", name: "u8", age: 29, bio: "u8bio", profileImageUrl: "ai_woman3"),
        .init(id: NSUUID().uuidString, email: "u9@gmail.com", name: "u9", age: 29, bio: "u9bio", profileImageUrl: "ai_woman4"),
        .init(id: NSUUID().uuidString, email: "u10@gmail.com", name: "Carol", age: 29, bio: "u10bio", profileImageUrl: "ai_woman5"),
    ]
}
