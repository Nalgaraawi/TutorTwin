import SwiftUI

enum AppTab {
    case current
    case calendar
    case profile
}

struct TabBar: View {
    let selectedTab: AppTab

    var body: some View {
        HStack {
            Spacer()

            NavigationLink {
                ReadingDiscoveryView(mode: "Reading")
            } label: {
                TabItem(icon: "square.and.pencil", title: "Current", isSelected: selectedTab == AppTab.current)
            }

            Spacer()

            NavigationLink {
                CalendarView()
            } label: {
                TabItem(icon: "calendar", title: "Calendar", isSelected: selectedTab == AppTab.calendar)
            }

            Spacer()

            NavigationLink {
                ProfileView()
            } label: {
                TabItem(icon: "person.circle.fill", title: "Profile", isSelected: selectedTab == AppTab.profile)
            }

            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.95))
        .clipShape(Capsule())
        .shadow(radius: 5)
    }
}

struct TabItem: View {
    let icon: String
    let title: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
            Text(title)
                .font(.caption)
        }
        .foregroundStyle(isSelected ? .blue : .black)
    }
}
