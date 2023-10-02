import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            Spacer()
            ProgressView()
            Spacer()
        }
        .background(Color.black.opacity(0.25))
    }
}

struct LoadingOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlayView()
    }
}
