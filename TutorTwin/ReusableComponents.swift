import SwiftUI

struct PrimaryCapsuleButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(AppTheme.gotu(30))
            .minimumScaleFactor(0.65)
            .lineLimit(1)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 74)
            .background(AppTheme.primaryBlue)
            .clipShape(Capsule())
            .contentShape(Capsule())
    }
}

struct CircleIconButton: View {
    let systemName: String

    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .foregroundStyle(.black)
            .frame(width: 58, height: 58)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 6)
            .contentShape(Circle())
    }
}

struct AdaptivePillGrid: View {
    let items: [String]
    @Binding var selectedItem: String

    private let columns = [
        GridItem(.adaptive(minimum: 96), spacing: 14)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 14) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.system(size: 20))
                    .minimumScaleFactor(0.65)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(isSelected(item) ? .white : .gray)
                    .frame(minWidth: 92, minHeight: 54)
                    .padding(.horizontal, 10)
                    .background(isSelected(item) ? AppTheme.primaryBlue : Color.white)
                    .clipShape(Capsule())
                    .contentShape(Capsule())
                    .onTapGesture {
                        selectedItem = cleaned(item)
                    }
            }
        }
    }

    private func cleaned(_ item: String) -> String {
        item.replacingOccurrences(of: "\n", with: "")
    }

    private func isSelected(_ item: String) -> Bool {
        selectedItem == cleaned(item)
    }
}

struct PassageCard: View {
    let showText: Bool
    let showSpeaker: Bool

    let passage = """
    Maya woke up early because she was excited for the school science fair. She had spent all week building a small model of a bridge using popsicle sticks and glue. Before leaving, she checked her project one more time to make sure nothing was broken.

    At the science fair, Maya noticed that her friend Jordan looked worried because his volcano model had fallen apart. Maya remembered how hard she worked on her own project, so she decided to help him rebuild it before the judging started.

    When the judges arrived, both Maya and Jordan stood proudly beside their projects.
    """

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white.opacity(0.85))
                .shadow(radius: 8)

            if showText {
                ScrollView {
                    Text(passage)
                        .font(.system(size: 16))
                        .foregroundStyle(.black)
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            if showSpeaker {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.title2)
                    .foregroundStyle(AppTheme.primaryBlue)
                    .padding()
            }
        }
    }
}

//struct TabBar: View {
//    var body: some View {
//        HStack {
//            Spacer()
//
//            NavigationLink {
//                ReadingDiscoveryView(mode: "Reading")
//            } label: {
//                VStack(spacing: 4) {
//                    Image(systemName: "square.and.pencil")
//                    Text("Current")
//                        .font(.caption)
//                }
//            }
//            .foregroundStyle(.blue)
//
//            Spacer()
//
//            NavigationLink {
//                CalendarView()
//            } label: {
//                VStack(spacing: 4) {
//                    Image(systemName: "calendar")
//                    Text("Calendar")
//                        .font(.caption)
//                }
//            }
//            .foregroundStyle(.black)
//
//            Spacer()
//
//            NavigationLink {
//                ProfileView()
//            } label: {
//                VStack(spacing: 4) {
//                    Image(systemName: "person.circle.fill")
//                    Text("Profile")
//                        .font(.caption)
//                }
//            }
//            .foregroundStyle(.black)
//
//            Spacer()
//        }
//        .padding(.vertical, 12)
//        .background(Color.white.opacity(0.95))
//        .clipShape(Capsule())
//        .shadow(radius: 5)
//    }
//}
