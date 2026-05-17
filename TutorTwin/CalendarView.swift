//
//  CalendarView.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/17/26.
//


import SwiftUI

struct CalendarView: View {
    let availableTimes = [
        "Monday: 4:00 PM - 7:00 PM",
        "Tuesday: 4:00 PM - 7:00 PM",
        "Wednesday: 4:00 PM - 7:00 PM",
        "Thursday: 4:00 PM - 7:00 PM",
        "Saturday: 10:00 AM - 1:00 PM"
    ]

    let meetingTimes = [
        "Monday, May 18 — 4:30 PM",
        "Wednesday, May 20 — 5:00 PM",
        "Saturday, May 23 — 11:00 AM"
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Calendar")
                        .font(AppTheme.gotu(34))
                        .padding(.top, 35)

                    Text("Mentor Availability")
                        .font(AppTheme.gotu(26))

                    VStack(spacing: 14) {
                        ForEach(availableTimes, id: \.self) { time in
                            CalendarTimeCard(text: time)
                        }
                    }

                    Text("Upcoming Meetings")
                        .font(AppTheme.gotu(26))
                        .padding(.top, 10)

                    VStack(spacing: 14) {
                        ForEach(meetingTimes, id: \.self) { meeting in
                            CalendarMeetingCard(text: meeting)
                        }
                    }

                    Button {

                    } label: {
                        PrimaryCapsuleButton(title: "Set Up Meeting")
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 10)

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 28)
            }

            TabBar(selectedTab: AppTab.calendar)
//                .padding(.horizontal, 18)
//                .padding(.bottom, 8)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}

struct CalendarTimeCard: View {
    let text: String

    var body: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundStyle(AppTheme.primaryBlue)

            Text(text)
                .font(.system(size: 18))

            Spacer()
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct CalendarMeetingCard: View {
    let text: String

    var body: some View {
        HStack {
            Image(systemName: "person.2.fill")
                .foregroundStyle(AppTheme.primaryBlue)

            Text(text)
                .font(.system(size: 18))

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
