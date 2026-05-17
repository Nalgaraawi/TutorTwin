import SwiftUI

struct VolunteerVerificationView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Select Institution")
                    .font(AppTheme.gotu(34))
                    .minimumScaleFactor(0.65)
                    .lineLimit(1)
                    .padding(.top, 25)

                SearchBar()

                Text("Proof of attendance")
                    .font(AppTheme.gotu(28))
                    .minimumScaleFactor(0.75)

                Text("Upload documents to verify status (transcript, School ID, Letter of Acceptance)")
                    .foregroundStyle(.gray)
                    .font(.body)

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.12))
                    .frame(height: 300)
                    .overlay {
                        VStack(spacing: 14) {
                            Image(systemName: "arrow.up.doc.fill")
                                .font(.system(size: 52))
                                .foregroundStyle(Color.gray.opacity(0.45))

                            Text("Tap to upload document")
                                .font(.system(size: 16))
                                .foregroundStyle(.gray)
                        }
                    }

                HStack(spacing: 25) {
                    CircleIconButton(systemName: "arrow.uturn.left")

                    CircleIconButton(systemName: "square.and.arrow.up")

                    NavigationLink(destination: CameraScannerView()) {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .foregroundStyle(.black)
                            .frame(width: 58, height: 58)
                            .background(AppTheme.primaryBlue)
                            .clipShape(Circle())
                            .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 22)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}
