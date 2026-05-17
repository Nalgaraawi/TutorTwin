import SwiftUI

struct StudentSignUpView: View {
    let grades = ["Kindergarten", "1st Grade", "2nd Grade", "3rd Grade", "4th Grade",
                  "5th Grade", "6th Grade", "7th Grade", "8th Grade", "9th Grade",
                  "10th Grade", "11th Grade", "12th Grade"]

    let interests = ["Sports", "Crafts", "Writing", "Shows/\nMovies", "Music", "Reading", "Baking", "Gaming"]
    let learningStyles = ["Audio", "Visual", "Reading"]

    @State private var selectedGrade = "Select Grade"
    @State private var selectedInterest = "Crafts"
    @State private var selectedLearningStyle = "Reading"

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    Text("Select grade level")
                        .font(AppTheme.gotu(34))
                        .minimumScaleFactor(0.65)
                        .lineLimit(1)
                        .padding(.top, 25)

                    Menu {
                        ForEach(grades, id: \.self) { grade in
                            Button(grade) { selectedGrade = grade }
                        }
                    } label: {
                        HStack {
                            Text(selectedGrade)
                                .font(.system(size: 20))
                                .foregroundStyle(selectedGrade == "Select Grade" ? .gray : .black)

                            Spacer()

                            Image(systemName: "chevron.down")
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 24)
                        .frame(height: 62)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Capsule())
                        .contentShape(Capsule())
                    }
                    .buttonStyle(.plain)

                    Text("Interests")
                        .font(AppTheme.gotu(28))
                        .minimumScaleFactor(0.75)

                    AdaptivePillGrid(items: interests, selectedItem: $selectedInterest)

                    Text("Learning Style")
                        .font(AppTheme.gotu(28))
                        .minimumScaleFactor(0.75)

                    AdaptivePillGrid(items: learningStyles, selectedItem: $selectedLearningStyle)

                    Spacer(minLength: 110)
                }
                .padding(.horizontal, 28)
            }

            NavigationLink {
                ReadingDiscoveryView(mode: selectedLearningStyle)
            } label: {
                PrimaryCapsuleButton(title: "Create Profile")
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 28)
            .padding(.bottom, 45)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}
