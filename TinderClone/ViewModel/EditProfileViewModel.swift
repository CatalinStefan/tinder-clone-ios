import Foundation
import PhotosUI
import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImageFromItem(item: selectedImage)
            }
        }
    }
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    @Published var name: String
    @Published var profileImageUrl: String
    @Published var bio: String
    @Published var age: Int
    @Published var gender = TinderGender.unspecified
    @Published var preference = TinderGender.unspecified
    @Published var interests: Set<String> = []
    
    init(user: User) {
        self.user = user
        self.name = user.name
        self.bio = user.bio ?? ""
        self.age = user.age ?? 18
        self.gender = TinderGender.fromString(str: user.gender)
        self.preference = TinderGender.fromString(str: user.preference)
        self.profileImageUrl = user.profileImageUrl ?? ""
        self.interests = Set(user.interests)
    }
    
    @MainActor
    func loadImageFromItem(item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        data["bio"] = bio
        data["age"] = age
        data["gender"] = gender.rawValue
        data["preference"] = preference.rawValue
        data["interests"] = Array(interests)
        
        try await Firestore.firestore().collection("user").document(user.id).updateData(data)
        try await AuthService.shared.fetchUser()
    }
}
