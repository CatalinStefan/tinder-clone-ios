import SwiftUI

struct RegisterBioView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Step 4 of 6")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            Text("Hey, \(viewModel.currentUser?.name ?? "")")
                .font(.title)
                .padding()
            Text("Write a few words about yourself.")
                .font(.headline)
                .padding()
            
            Divider()
            
            TextEditor(text: $viewModel.bio)
                .frame(width: 300, height: 150, alignment: .topLeading)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding()
            
            NavigationLink {
                RegisterInterestsView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .padding()

            
            Button {
                viewModel.skipRegistrationFlow()
                dismiss()
            } label: {
                Text("skip for now")
            }
            .foregroundColor(.gray)
            
            Spacer()

        }
    }
}

struct RegisterBioView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterBioView()
            .environmentObject(AuthViewModel())
    }
}
