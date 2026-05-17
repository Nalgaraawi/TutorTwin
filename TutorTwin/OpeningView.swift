// OpeningView.swift

import SwiftUI

struct OpeningView: View {
    var body: some View {
        VStack {
            Spacer()

            // Replace "TutorTwinLogo" with your asset name
            Image("TutorTwinLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
                .padding(.bottom, 30)

            Text("Students Helping Students")
                .font(AppTheme.gotu(34))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .padding(.horizontal, 30)

            Spacer()

            NavigationLink {
                RoleSelectionView()
            } label: {
                PrimaryCapsuleButton(title: "Get Started")
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 35)
            .padding(.bottom, 60)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
