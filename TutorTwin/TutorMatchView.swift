import SwiftUI

struct TutorMatchView: View {
    @State private var isLoading = false
    @State private var showMatch = false
    @State private var matchReason = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                Text("Your TwinTutor Match")
                    .font(AppTheme.gotu(30))
                    .padding(.top, 50)

                // Combined student + volunteer card
                VStack(spacing: 0) {
                    PersonRow(
                        role: "Student",
                        icon: "person.fill",
                        name: "Maya Chen",
                        detail: "6th Grade · Reading, Music, Gaming",
                        availability: "Mon–Thu: 4–7 PM"
                    )

                    HStack(spacing: 10) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.gray.opacity(0.15))

                        Label("AI Matched", systemImage: "wand.and.stars")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppTheme.primaryBlue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(AppTheme.primaryBlue.opacity(0.10))
                            .clipShape(Capsule())
                            .fixedSize()

                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.gray.opacity(0.15))
                    }
                    .padding(.horizontal, 20)

                    PersonRow(
                        role: "Volunteer",
                        icon: "graduationcap.fill",
                        name: "Jordan Baker",
                        detail: "College · Reading, Writing, Music",
                        availability: "Mon–Thu: 4–7 PM · Sat: 10 AM–1 PM"
                    )
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 3)
                .padding(.horizontal, 20)

                // AI reason card — appears after tapping Generate
                if showMatch {
                    VStack(spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                            Text("95% Match")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.green)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.10))
                        .clipShape(Capsule())

                        Text(matchReason.isEmpty
                             ? "Maya and Jordan share a passion for reading and music, and their schedules align perfectly Monday–Thursday from 4–7 PM. Jordan's background in creative writing makes them an ideal mentor to help Maya strengthen her reading comprehension and develop her own voice."
                             : matchReason)
                            .font(.body)
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.horizontal, 20)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }

                Button {
                    generateMatch()
                } label: {
                    PrimaryCapsuleButton(title: isLoading ? "Matching..." : "Generate AI Match")
                }
                .buttonStyle(.plain)
                .disabled(isLoading || showMatch)
                .padding(.horizontal, 35)

                NavigationLink {
                    ReadingDiscoveryView(mode: "Reading")
                } label: {
                    PrimaryCapsuleButton(title: "Continue")
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: showMatch)
    }

    func generateMatch() {
        isLoading = true
        Task {
            do {
                let prompt = """
                You are TutorTwin's AI matching assistant.

                Student: Maya Chen, 6th Grade
                Interests: Reading, Music, Gaming
                Availability: Monday–Thursday, 4–7 PM

                Volunteer: Jordan Baker, College
                Interests: Reading, Writing, Music
                Availability: Monday–Thursday, 4–7 PM; Saturday 10 AM–1 PM

                In exactly 2 short sentences, explain why this is a strong tutoring match.
                Be warm, specific, and encouraging.
                """
                let reason = try await GeminiService.shared.generate(prompt: prompt)
                matchReason = reason
            } catch {
                matchReason = "Maya and Jordan share a passion for reading and music, and their schedules align perfectly Monday–Thursday. Jordan's background in creative writing makes them an ideal mentor for Maya's comprehension goals."
            }
            showMatch = true
            isLoading = false
        }
    }
}

struct PersonRow: View {
    let role: String
    let icon: String
    let name: String
    let detail: String
    let availability: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(AppTheme.primaryBlue)
                .frame(width: 44, height: 44)
                .background(AppTheme.primaryBlue.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 7) {
                    Text(name)
                        .font(AppTheme.gotu(18))

                    Text(role)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(AppTheme.primaryBlue)
                        .clipShape(Capsule())
                }

                Text(detail)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)

                Label(availability, systemImage: "clock")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
