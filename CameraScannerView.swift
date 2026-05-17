import SwiftUI

struct CameraScannerView: View {
    @State private var scannedText = ""
    @State private var aiResult = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Scan Verification Sheet")
                .font(AppTheme.gotu(30))
                .padding(.top, 30)

            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.85))
                .frame(height: 300)
                .overlay {
                    VStack(spacing: 12) {
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 60))
                            .foregroundStyle(AppTheme.primaryBlue)

                        Text("Tap below to scan proof of attendance")
                            .foregroundStyle(.gray)
                    }
                }

            Button {
                scannedText = "Student ID verified. School attendance confirmed."
                verifyDocument()
            } label: {
                PrimaryCapsuleButton(title: isLoading ? "Scanning..." : "Scan Sheet")
            }
            .buttonStyle(.plain)
            .disabled(isLoading)

            if !aiResult.isEmpty {
                Text(aiResult)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            Spacer()

            NavigationLink {
                MentorSignUpView()
            } label: {
                PrimaryCapsuleButton(title: "Continue")
            }
            .buttonStyle(.plain)
            .padding(.bottom, 35)
        }
        .padding(.horizontal, 28)
        .background(AppTheme.background.ignoresSafeArea())
    }

    func verifyDocument() {
        isLoading = true

        Task {
            do {
                let prompt = """
                You are an AI verification assistant for TutorTwin.
                Review this scanned school document text and say whether the volunteer appears verified.
                Keep the answer short.

                Scanned text:
                \(scannedText)
                """

                aiResult = try await WatsonXService.shared.generate(prompt: prompt)
            } catch {
                aiResult = "Could not verify document. Please try again."
            }

            isLoading = false
        }
    }
}
