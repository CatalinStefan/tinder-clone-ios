import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BrandingImage()
                    
                    Text("Login")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(spacing: 32) {
                        TinderInputField(imageName: "envelope", placeholderText: "email", text: $viewModel.email)
                        TinderInputField(imageName: "lock", placeholderText: "password", text: $viewModel.password, isSecureField: true)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    
                    Button {
                        Task {
                            try await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                    }
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    
                    Spacer()
                    
                    NavigationLink {
                        RegisterView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.footnote)
                            Text("Sign up")
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .padding(.bottom, 48)
                    .foregroundColor(.blue)
                    
                    
                }
                
                if $viewModel.isLoading.wrappedValue {
                    LoadingOverlayView()
                }
            }
            .alert(viewModel.errorEvent.content, isPresented: $viewModel.errorEvent.display) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
