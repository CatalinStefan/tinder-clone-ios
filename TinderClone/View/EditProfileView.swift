import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                EditHeaderView()
                
                EditProfileImageView()
                
                EditNameAgeView()
                
                EditBioView()
                
                EditPreferenceView()
                
                EditInterestsView()
            }
        }
        .environmentObject(viewModel)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.mockUsers[0])
    }
}

struct EditHeaderView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                Task {
                    try await viewModel.updateUserData()
                }
                dismiss()
            } label: {
                Text("Save")
                    .bold()
            }
        }
        .padding()
        
        Divider()
    }
}

struct EditProfileImageView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    
    var body: some View {
        PhotosPicker(selection: $viewModel.selectedImage) {
            HStack {
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    if let displaySelectedImage = viewModel.profileImage {
                        displaySelectedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .clipShape(Circle())
                    } else {
                        RoundImageView(imageUrl: viewModel.profileImageUrl, imageSize: .xlarge)
                    }
                    
                    Image(systemName: "pencil")
                        .resizable()
                        .padding(12)
                        .background(.green)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .containerShape(Circle())
                }
                Spacer()
            }
            .padding()
            
        }
        
        Divider()
    }
}

struct EditNameAgeView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.name)
                .font(.title)
                .bold()
            Spacer()
        }
        .padding()
        
        HStack {
            Text("Age")
                .font(.title2)
            Picker("Choose", selection: $viewModel.age) {
                ForEach(18...100, id: \.self) { age in
                    Text(String(age))
                }
            }
        }
        .padding()
        
        Divider()
    }
}

struct EditBioView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    
    var body: some View {
        Text("About me")
            .font(.title2)
            .padding()
        TextField("Bio", text: $viewModel.bio, axis: .vertical)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray, lineWidth: 1)
            )
            .lineLimit(6)
            .padding()
        Divider()
    }
}

struct EditPreferenceView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    
    var body: some View {
        HStack {
            Text("I am a")
                .padding(.trailing)
                .frame(width: 150, alignment: .leading)
            Picker("Choose", selection: $viewModel.gender) {
                ForEach(TinderGender.allCases) { gender in
                    switch gender {
                    case TinderGender.man: Text("Man")
                    case TinderGender.woman: Text("Woman")
                    case TinderGender.unspecified: Text("Unspecified")
                    }
                }
            }
        }
        .padding()
        HStack {
            Text("Looking for")
                .padding(.trailing)
                .frame(width: 150, alignment: .leading)
            Picker("Choose", selection: $viewModel.preference) {
                ForEach(TinderGender.allCases) { gender in
                    switch gender {
                    case TinderGender.man: Text("Men")
                    case TinderGender.woman: Text("Women")
                    case TinderGender.unspecified: Text("Any")
                    }
                }
            }
        }
        .padding()
        
        Divider()
    }
}

struct EditInterestsView: View {
    @EnvironmentObject var viewModel: EditProfileViewModel
    
    var body: some View {
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
    }
}
