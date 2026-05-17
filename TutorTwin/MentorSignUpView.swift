import SwiftUI

struct MentorSignUpView: View {
    let interests = ["Sports", "Crafts", "Writing", "Shows/Movies", "Music", "Reading", "Baking", "Gaming"]
    let days = ["M", "T", "W", "Th", "F"]
    let timeSlots = ["3:00 PM – 4:00 PM", "4:00 PM – 6:00 PM", "6:00 PM – 8:00 PM"]

    @State private var selectedInterest = "Sports"
    @State private var selectedDay = "M"
    @State private var selectedTimeSlot = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Interests")
                        .font(AppTheme.gotu(34))
                        .padding(.top, 35)

                    FlowLayout(items: interests, selectedItem: $selectedInterest)

                    Text("Volunteer Availability")
                        .font(AppTheme.gotu(28))
                        .minimumScaleFactor(0.75)

                    HStack(spacing: 20) {
                        ForEach(days, id: \.self) { day in
                            Text(day)
                                .font(.title3)
                                .foregroundStyle(selectedDay == day ? .white : .gray)
                                .frame(width: 44, height: 36)
                                .background(selectedDay == day ? AppTheme.primaryBlue : Color.white)
                                .clipShape(Capsule())
                                .onTapGesture { selectedDay = day }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut, value: selectedDay)

                    VStack(spacing: 12) {
                        ForEach(timeSlots, id: \.self) { slot in
                            Button {
                                selectedTimeSlot = slot
                            } label: {
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundStyle(selectedTimeSlot == slot ? .white : AppTheme.primaryBlue)
                                    Text(slot)
                                        .font(.system(size: 17))
                                        .foregroundStyle(selectedTimeSlot == slot ? .white : .black)
                                    Spacer()
                                    if selectedTimeSlot == slot {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(selectedTimeSlot == slot ? AppTheme.primaryBlue : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .animation(.easeInOut, value: selectedTimeSlot)

                    Spacer(minLength: 110)
                }
                .padding(.horizontal, 26)
            }

            NavigationLink {
                TutorMatchView()
            } label: {
                PrimaryCapsuleButton(title: "Create Profile")
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 26)
            .padding(.bottom, 45)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}
