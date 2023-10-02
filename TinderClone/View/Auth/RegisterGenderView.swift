import SwiftUI

struct RegisterGenderView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Step 3 of 6")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
            Text("Hey, \(viewModel.currentUser?.name ?? "")")
                .font(.title)
                .padding()
            Text("What are you looking for?")
                .font(.headline)
                .padding()
            
            Divider()
            
            HStack {
                Text("I am a")
                    .padding(.trailing)
                    .frame(width: 150, alignment: .trailing)
                Picker("Choose", selection: $viewModel.gender) {
                    ForEach(TinderGender.allCases) { gender in
                        switch gender {
                        case TinderGender.man: Text("Man")
                        case TinderGender.woman: Text("Woman")
                        case TinderGender.unspecified: Text("Unspecified")
                        }
                    }
                }
                .frame(width: 150, alignment: .leading)
            }
            
            Divider()
            
            HStack {
                Text("Looking for")
                    .padding(.trailing)
                    .frame(width: 150, alignment: .trailing)
                Picker("Choose", selection: $viewModel.preference) {
                    ForEach(TinderGender.allCases) { gender in
                        switch gender {
                        case TinderGender.man: Text("Men")
                        case TinderGender.woman: Text("Women")
                        case TinderGender.unspecified: Text("Any")
                        }
                    }
                }
                .frame(width: 150, alignment: .leading)
            }
            
            NavigationLink {
                RegisterBioView()
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

struct RegisterGenderView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterGenderView()
            .environmentObject(AuthViewModel())
    }
}
