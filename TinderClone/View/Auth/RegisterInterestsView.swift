import SwiftUI

struct RegisterInterestsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Step 5 of 6")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
                Text("Hey, \(viewModel.currentUser?.name ?? "")")
                    .font(.title)
                    .padding()
                Text("Pick a few of your interests.")
                    .font(.headline)
                    .padding()
                
                Divider()
                
                let gridItems: [GridItem] = [
                    .init(.flexible(), spacing: 1),
                    .init(.flexible(), spacing: 1),
                    .init(.flexible(), spacing: 1)
                ]
                
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(TinderInterests.allCases, id: \.self) { item in
                        let selected = viewModel.interests.contains(item.rawValue)
                        Text(String(describing: item))
                            .padding(8)
                            .foregroundColor(selected ? .white : .black)
                            .background(selected ? .blue : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                            .onTapGesture {
                                if selected {
                                    viewModel.interests.remove(item.rawValue)
                                } else {
                                    viewModel.interests.insert(item.rawValue)
                                }
                            }
                    }
                }
                .padding()
                
                NavigationLink {
                    RegisterCompletionView()
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
}

struct RegisterInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterInterestsView()
            .environmentObject(AuthViewModel())
    }
}
