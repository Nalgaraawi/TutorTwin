import SwiftUI

struct CameraScannerView: View {
    @State private var aiResult = ""
    @State private var isLoading = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Text("Scan Verification Sheet")
                        .font(AppTheme.gotu(30))
                        .padding(.top, 30)

                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white.opacity(0.85))
                        .frame(height: 300)
                        .overlay {
                            VStack(spacing: 14) {
                                Image(systemName: "camera.viewfinder")
                                    .font(.system(size: 60))
                                    .foregroundStyle(AppTheme.primaryBlue)

                                Text("Tap below to scan proof of attendance")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.gray)
                            }
                        }

                    Button {
                        verifyDocument()
                    } label: {
                        PrimaryCapsuleButton(title: isLoading ? "Scanning..." : "Scan Sheet")
                    }
                    .buttonStyle(.plain)
                    .disabled(isLoading)

                    if !aiResult.isEmpty {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                                .font(.title3)

                            VStack(alignment: .leading, spacing: 3) {
                                Text("Verified")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.green)
                                Text(aiResult)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 28)
            }

            NavigationLink {
                MentorSignUpView()
            } label: {
                PrimaryCapsuleButton(title: "Continue")
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 28)
            .padding(.bottom, 35)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .animation(.easeInOut, value: aiResult)
    }

    func verifyDocument() {
        isLoading = true
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            aiResult = "Student ID and school enrollment confirmed. Jordan Baker is an active student at Riverside College."
            isLoading = false
        }
    }
}
