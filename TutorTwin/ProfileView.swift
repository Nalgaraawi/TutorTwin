//
//  ProfileView.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/17/26.
//


import SwiftUI

struct ProfileView: View {
    @State private var selectedRole = "Student"

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Profile")
                        .font(AppTheme.gotu(34))
                        .padding(.top, 35)

                    HStack(spacing: 14) {
                        ProfileRoleButton(title: "Student", selectedRole: $selectedRole)
                        ProfileRoleButton(title: "Volunteer", selectedRole: $selectedRole)
                    }

                    if selectedRole == "Student" {
                        StudentProfileSection()
                    } else {
                        VolunteerProfileSection()
                    }

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 28)
            }

            TabBar(selectedTab: AppTab.profile)
                .padding(.horizontal, 18)
                .padding(.bottom, 8)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}

struct ProfileRoleButton: View {
    let title: String
    @Binding var selectedRole: String

    var body: some View {
        Button {
            selectedRole = title
        } label: {
            Text(title)
                .font(.system(size: 18))
                .foregroundStyle(selectedRole == title ? .white : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(selectedRole == title ? AppTheme.primaryBlue : Color.white)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct StudentProfileSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Student Progress")
                .font(AppTheme.gotu(26))

            ProfileInfoCard(title: "Reading Level", value: "Building comprehension")
            ProfileInfoCard(title: "Latest AI Feedback", value: "Practice explaining why characters make choices.")
            ProfileInfoCard(title: "Completed Passages", value: "3 short passages")
            ProfileInfoCard(title: "Vocabulary Support", value: "Needs support with story details and predictions.")
        }
    }
}

struct VolunteerProfileSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Volunteer Tracking")
                .font(AppTheme.gotu(26))

            ProfileInfoCard(title: "Matched Student", value: "Jordan Bakers")
            ProfileInfoCard(title: "Availability", value: "Mon-Thu: 4 PM - 7 PM\nSat: 10 AM - 1 PM")
            ProfileInfoCard(title: "Interests", value: "Reading, Writing, Music")
            ProfileInfoCard(title: "Sessions Completed", value: "2 tutoring sessions")
        }
    }
}

struct ProfileInfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))

            Text(value)
                .font(.system(size: 17))
                .foregroundStyle(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
