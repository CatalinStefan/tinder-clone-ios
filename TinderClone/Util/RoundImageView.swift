import SwiftUI
import Kingfisher

enum ImageSize: CGFloat {
    case small = 36
    case medium = 48
    case large = 64
    case xlarge = 128
}

struct RoundImageView: View {
    let imageUrl: String?
    var imageSize: ImageSize = .small
    
    var body: some View {
        if let imageUrl = imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: imageSize.rawValue, height: imageSize.rawValue)
                .clipShape(Circle())
        } else {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.rawValue, height: imageSize.rawValue)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}
