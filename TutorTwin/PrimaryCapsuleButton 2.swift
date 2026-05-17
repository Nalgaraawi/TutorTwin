//
//  PrimaryCapsuleButton 2.swift
//  TutorTwin
//
//  Created by Sukeina Ammar on 5/17/26.
//


import SwiftUI

// MARK: - Primary Capsule Button

struct PrimaryCapsuleButton2: View {
    let title: String

    var body: some View {
        Text(title)
            .font(AppTheme.gotu(30))
            .minimumScaleFactor(0.7)
            .lineLimit(1)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 74)
            .background(AppTheme.primaryBlue)
            .clipShape(Capsule())
            .contentShape(Capsule())
    }
}

// MARK: - Circle Icon Button

struct CircleIconButton2: View {
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

// MARK: - Question Field

struct QuestionField2: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .clipShape(Capsule())
            .font(.system(size: 20))
    }
}

// MARK: - Passage Card

struct PassageCard2: View {
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
                        .padding(20)
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
        .frame(height: 250)
    }
}

// MARK: - Bottom Tab Bar

struct TabBar2: View {
    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 4) {
                Image(systemName: "square.and.pencil")
                Text("Current")
                    .font(.caption)
            }
            .foregroundStyle(.blue)

            Spacer()

            VStack(spacing: 4) {
                Image(systemName: "calendar")
                Text("Calendar")
                    .font(.caption)
            }

            Spacer()

            VStack(spacing: 4) {
                Image(systemName: "person.circle.fill")
                Text("Profile")
                    .font(.caption)
            }

            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.95))
        .clipShape(Capsule())
    }
}

