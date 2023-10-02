import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.currentUser == nil || viewModel.signupFlowActive {
            LoginView()
        } else {
            if let user = viewModel.currentUser {
                MainTabView(user: user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
