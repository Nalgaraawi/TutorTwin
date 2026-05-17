//
//  RoleSelectionView.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/16/26.
//


// RoleSelectionView.swift

import SwiftUI

struct RoleSelectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("I am a...")
                .font(AppTheme.gotu(34))
                .padding(.top, 40)
                .padding(.leading, 40)

            Spacer()

            VStack(spacing: 70) {
                NavigationLink {
                    StudentSignUpView()
                } label: {
                    ButtonStyleView(title: "Student")
                }

                NavigationLink {
                    VolunteerVerificationView()
                } label: {
                    ButtonStyleView(title: "Volunteer")
                }
            }

            Spacer()
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}

struct ButtonStyleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(AppTheme.gotu(28))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .background(AppTheme.primaryBlue)
            .clipShape(Capsule())
            .padding(.horizontal, 26)
    }
}