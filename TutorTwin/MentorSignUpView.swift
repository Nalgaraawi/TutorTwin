//
//  MentorSignUpView.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/16/26.
//


// MentorSignUpView.swift

import SwiftUI

struct MentorSignUpView: View {
    let interests = ["Sports", "Crafts", "Writing", "Shows/Movies", "Music", "Reading", "Baking", "Gaming"]
    let days = ["M", "T", "W", "Th", "F"]

    @State private var selectedInterest = "Sports"
    @State private var selectedDay = "M"

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Interests")
                .font(.largeTitle)
                .padding(.top, 35)

            FlowLayout(items: interests, selectedItem: $selectedInterest)

            Text("Volunteer Availability")
                .font(.title)

            HStack(spacing: 24) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .frame(width: 44, height: 36)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .onTapGesture {
                            selectedDay = day
                        }
                }
            }
            .frame(maxWidth: .infinity)

            VStack(spacing: 14) {
                Text("3:00 PM - 4:00 PM")
                Text("4:00 PM - 6:00 PM")
            }
            .font(.title3)
            .padding(.top, 5)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black)

            Spacer()

            NavigationLink {
                TutorMatchView()
            } label: {
                Text("Create Profile")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.primaryBlue)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 45)
        }
        .padding(.horizontal, 26)
        .background(AppTheme.background.ignoresSafeArea())
    }
}