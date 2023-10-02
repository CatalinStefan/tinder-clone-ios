import Foundation

enum TinderGender: String, CaseIterable, Identifiable, Codable {
    case man = "man"
    case woman = "woman"
    case unspecified = "unspecified"
    
    var id: Self { self }
    
    static func fromString(str: String) -> TinderGender {
        switch str.lowercased() {
        case "man": return .man
        case "woman": return .woman
        default: return .unspecified
        }
    }
}
