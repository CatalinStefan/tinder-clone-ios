import Foundation
import Combine
import SwiftUI
import PhotosUI

@MainActor
class AuthViewModel: ObservableObject {
    private var auth = AuthService.shared
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var age = 18
    @Published var gender: TinderGender = .unspecified
    @Published var preference: TinderGender = .unspecified
    @Published var bio = ""
    @Published var interests: Set<String> = []
    
    @Published var isLoading = AuthService.shared.isLoading
    private var cancellables = Set<AnyCancellable> ()
    @Published var errorEvent = AuthService.shared.errorEvent
    @Published var currentUser = AuthService.shared.currentUser
    
    @Published var signupFlowActive = AuthService.shared.signupFlowActive
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await auth.loadImageFromItem(item: selectedImage)
            }
        }
    }
    @Published var profileImage = AuthService.shared.profileImage
    
    init() {
//        auth.signout()
        setupSubscribers()
    }
    
    func setupSubscribers() {
        auth.$isLoading.sink { [weak self] isLoading in
            self?.isLoading = isLoading
        }
        .store(in: &cancellables)
        
        auth.$errorEvent.sink { [weak self] errorEvent in
            self?.errorEvent = errorEvent
        }
        .store(in: &cancellables)
        
        auth.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
        
        auth.$signupFlowActive.sink { [weak self] signupFlowActive in
            self?.signupFlowActive = signupFlowActive
        }
        .store(in: &cancellables)
        
        auth.$profileImage.sink { [weak self] profileImage in
            self?.profileImage = profileImage
        }
        .store(in: &cancellables)
    }
    
    func register(onComplete: () -> ()) async throws {
        await auth.register(withEmail: email, name: name, password: password, onComplete: onComplete)
        email = ""
        password = ""
        name = ""
    }
    
    func login() async throws {
        await auth.login(withEmail: email, password: password)
        email = ""
        password = ""
    }
    
    func skipRegistrationFlow() {
        signupFlowActive = false
    }
    
    func uploadUserImage() async throws {
        await auth.uploadUserImage()
    }
    
    func completeRegistrationFlow() async throws {
        await auth.completeRegistrationFlow(age: age, bio: bio, gender: gender, preference: preference, interests: interests)
        
        email = ""
        password = ""
        name = ""
        age = 18
        gender = .unspecified
        preference = .unspecified
        bio = ""
        interests = []
        selectedImage = nil
        profileImage = nil
    }
}
