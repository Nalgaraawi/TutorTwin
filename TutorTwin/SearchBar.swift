//
//  SearchBar.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/16/26.
//


// ReusableComponents.swift

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title2)

            Spacer()
        }
        .padding()
        .frame(height: 62)
        .background(Color.white.opacity(0.85))
        .clipShape(Capsule())
    }
}

//struct CircleIconButton: View {
//    let systemName: String
//
//    var body: some View {
//        Image(systemName: systemName)
//            .font(.title)
//            .foregroundStyle(.black)
//            .frame(width: 58, height: 58)
//            .background(Color.white)
//            .clipShape(Circle())
//            .shadow(radius: 8)
//    }
//}

struct FlowLayout: View {
    let items: [String]
    @Binding var selectedItem: String

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 100), spacing: 8)
        ], spacing: 12) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.title3)
                    .foregroundStyle(selectedItem == item ? .white : .gray)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(selectedItem == item ? AppTheme.primaryBlue : Color.white)
                    .clipShape(Capsule())
                    .onTapGesture {
                        selectedItem = item
                    }
            }
        }
    }
}

//struct PassageCard: View {
//    let showText: Bool
//    let showSpeaker: Bool
//
//    let passage = """
//    Maya woke up early because she was excited for the school science fair. She had spent all week building a small model of a bridge using popsicle sticks and glue. Before leaving, she checked her project one more time to make sure nothing was broken.
//
//    At the science fair, Maya noticed that her friend Jordan looked worried because his volcano model had fallen apart. Maya remembered how hard she worked on her own project, so she decided to help him rebuild it before the judging started.
//
//    When the judges arrived, both Maya and Jordan stood proudly beside their projects.
//    """
//
//    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.white.opacity(0.7))
//                .shadow(radius: 7)
//
//            if showText {
//                Text(passage)
//                    .font(.caption)
//                    .padding(22)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//
//            if showSpeaker {
//                Image(systemName: "speaker.wave.2.fill")
//                    .foregroundStyle(AppTheme.primaryBlue)
//                    .font(.title3)
//                    .padding()
//            }
//        }
//        .frame(height: 250)
//    }
//}

struct QuestionField: View {
    let text: String

    var body: some View {
        Text(text)
            .foregroundStyle(.gray)
            .font(.title3)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, minHeight: 43, alignment: .leading)
            .background(Color.white)
            .clipShape(Capsule())
    }
}

//struct TabBar: View {
//    var body: some View {
//        HStack {
//            Spacer()
//            VStack {
//                Image(systemName: "square.and.pencil")
//                Text("Current")
//                    .font(.caption)
//            }
//            .foregroundStyle(.blue)
//
//            Spacer()
//
//            VStack {
//                Image(systemName: "calendar")
//                Text("Calendar")
//                    .font(.caption)
//            }
//
//            Spacer()
//
//            VStack {
//                Image(systemName: "person.circle.fill")
//                Text("Profile")
//                    .font(.caption)
//            }
//
//            Spacer()
//        }
//        .padding(.vertical, 10)
//        .background(Color.white)
//        .clipShape(Capsule())
//    }
//}
