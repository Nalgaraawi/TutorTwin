import SwiftUI

struct TutorMatchView: View {
    @State private var matchReason = ""
    @State private var isLoading = false

    var body: some View {
        VStack {
            Text("Your TwinTutor Match")
                .font(AppTheme.gotu(30))
                .padding(.top, 50)

            Spacer()

            VStack(alignment: .leading, spacing: 24) {
                Text("Jordan Bakers")
                    .font(AppTheme.gotu(22))
                    .frame(maxWidth: .infinity)

                Divider()

                Text("School: Farewell Middle School")
                Text("Grade: Sixth")

                Divider()

                Text("Availability:")
                    .padding(.top, 10)

                Text("Mon-Thu: 4 - 7 PM")
                Text("Sat: 10 AM - 1 PM")
            }
            .font(.body)
            .padding(32)
            .frame(width: 320, height: 385)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 36))

            Button {
                generateMatch()
            } label: {
                PrimaryCapsuleButton(title: isLoading ? "Matching..." : "Generate AI Match")
            }
            .buttonStyle(.plain)
            .disabled(isLoading)
            .padding(.horizontal, 35)
            .padding(.top, 20)

            if !matchReason.isEmpty {
                Text(matchReason)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 28)
            }

            Spacer()

            NavigationLink {
                ReadingDiscoveryView(mode: "Reading")
            } label: {
                PrimaryCapsuleButton(title: "Continue")
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }

    func generateMatch() {
        isLoading = true

        Task {
            do {
                let prompt = """
                You are TutorTwin's AI matching bot.

                Match this student and volunteer based on interests and availability.

                Student:
                Interests: Reading, Gaming, Music
                Availability: Monday through Thursday, 4 PM to 7 PM

                Volunteer:
                Interests: Reading, Writing, Music
                Availability: Monday through Thursday, 4 PM to 7 PM

                Explain why this is a strong match in 2 short sentences.
                """

                matchReason = try await WatsonXService.shared.generate(prompt: prompt)
            } catch {
                matchReason = "Could not generate match."
            }

            isLoading = false
        }
    }
}
