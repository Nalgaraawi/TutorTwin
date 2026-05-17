//
//  VolunteerVerificationView.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/16/26.
//


// VolunteerVerificationView.swift

import SwiftUI

struct VolunteerVerificationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Select Institution")
                .font(.largeTitle)
                .padding(.top, 25)

            SearchBar()

            Text("Proof of attendance")
                .font(.title)

            Text("Upload documents to verify status (transcript, School ID, Letter of Acceptance)")
                .foregroundStyle(.gray)
                .font(.body)

            Rectangle()
                .fill(Color.gray.opacity(0.65))
                .frame(width: 285, height: 355)
                .frame(maxWidth: .infinity)

            Spacer()

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
            .padding(.bottom, 35)
        }
        .padding(.horizontal, 22)
        .background(AppTheme.background.ignoresSafeArea())
    }
}
