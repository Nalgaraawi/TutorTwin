import SwiftUI

struct ReadingDiscoveryView: View {
    let mode: String

    @State private var answerOne = "Maya woke up early and helped Jordan fix his volcano before judging started"
    @State private var answerTwo = "She helped because she knew how hard it was and didn't want him to fail"
    @State private var answerThree = "I think the judges will give both of them good grades because they worked hard"
    @State private var isLoading = false
    @State private var showAnalysisSheet = false
    @State private var analysisResult: AIAnalysisResult = .demo

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Literacy Discovery")
                        .font(AppTheme.gotu(30))
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .padding(.top, 25)

                    Text("Short Passage")
                        .font(AppTheme.gotu(24))

                    Text(instructionText)
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.primaryBlue)
                        .lineLimit(2)

                    PassageCard(showText: true, showSpeaker: mode == "Audio")
                        .frame(height: 300)

                    Text("Questions")
                        .font(AppTheme.gotu(24))

                    VStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("What happened first?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 4)
                            TextField("", text: $answerOne)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Why did the character do that?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 4)
                            TextField("", text: $answerTwo)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("What might happen next?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 4)
                            TextField("", text: $answerThree)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }

                    Spacer(minLength: 110)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 130)
            }

            Button {
                analyzeAnswers()
            } label: {
                PrimaryCapsuleButton(title: isLoading ? "Analyzing..." : "Analyze Answers")
            }
            .buttonStyle(.plain)
            .disabled(isLoading)
            .padding(.horizontal, 28)
            .padding(.bottom, 45)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .sheet(isPresented: $showAnalysisSheet) {
            AnalysisSheetView(result: analysisResult)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    var instructionText: String {
        mode == "Audio"
            ? "Student: Begin listening to the short passage, then answer the questions below."
            : "Student: Begin reading the short passage, then answer the questions below."
    }

    func analyzeAnswers() {
        isLoading = true
        Task {
            do {
                let prompt = """
                You are TutorTwin's literacy AI assistant. Analyze this 6th-grade student's reading comprehension.

                Passage:
                Maya woke up early because she was excited for the school science fair. She helped Jordan fix his project before judging started. When the judges arrived, both Maya and Jordan stood proudly beside their projects.

                Student answers:
                1. \(answerOne)
                2. \(answerTwo)
                3. \(answerThree)

                Respond in this EXACT format (no extra text):
                SCORE: [number 0-100]
                HEADLINE: [one short phrase like "Good comprehension" or "Strong start"]
                SUMMARY: [one sentence describing overall performance]
                STRENGTH1: [specific strength]
                STRENGTH2: [specific strength]
                STRENGTH3: [specific strength]
                IMPROVE1: [specific thing to improve]
                IMPROVE2: [specific thing to improve]
                IMPROVE3: [specific thing to improve]
                NEXT1: [actionable next step]
                NEXT2: [actionable next step]
                NEXT3: [actionable next step]
                """
                let raw = try await GeminiService.shared.generate(prompt: prompt)
                analysisResult = AIAnalysisResult.parse(raw) ?? .demo
            } catch {
                analysisResult = .demo
            }
            isLoading = false
            showAnalysisSheet = true
        }
    }
}

// MARK: - Analysis Result Model

struct AIAnalysisResult {
    let score: Int
    let headline: String
    let summary: String
    let strengths: [String]
    let improvements: [String]
    let nextSteps: [String]

    static let demo = AIAnalysisResult(
        score: 78,
        headline: "Good comprehension",
        summary: "Maya shows solid recall of story events and strong empathy understanding.",
        strengths: [
            "Strong recall — key story events remembered in order",
            "Correctly identified Maya's motivation for helping Jordan",
            "Good use of cause and effect across all three answers"
        ],
        improvements: [
            "Answer 1 combined two events — separate \"what happened first\" more clearly",
            "Answer 3 is vague — replace \"good grades\" with a specific prediction",
            "Practice prediction language: \"I think… because…\""
        ],
        nextSteps: [
            "Retell the story in exactly 3 sentences: First… Then… Finally…",
            "Practice story sequence — identify what happens first, next, and last",
            "Rewrite answer 3 with a specific prediction about each character's outcome"
        ]
    )

    static func parse(_ raw: String) -> AIAnalysisResult? {
        func value(for key: String) -> String? {
            raw.components(separatedBy: "\n")
                .first { $0.hasPrefix("\(key):") }?
                .dropFirst("\(key):".count)
                .trimmingCharacters(in: .whitespaces)
        }
        guard let scoreStr = value(for: "SCORE"), let score = Int(scoreStr),
              let headline = value(for: "HEADLINE"),
              let summary = value(for: "SUMMARY") else { return nil }

        let strengths = [value(for: "STRENGTH1"), value(for: "STRENGTH2"), value(for: "STRENGTH3")].compactMap { $0 }
        let improvements = [value(for: "IMPROVE1"), value(for: "IMPROVE2"), value(for: "IMPROVE3")].compactMap { $0 }
        let nextSteps = [value(for: "NEXT1"), value(for: "NEXT2"), value(for: "NEXT3")].compactMap { $0 }

        guard !strengths.isEmpty else { return nil }
        return AIAnalysisResult(score: score, headline: headline, summary: summary,
                                strengths: strengths, improvements: improvements, nextSteps: nextSteps)
    }
}

// MARK: - Analysis Sheet

struct AnalysisSheetView: View {
    let result: AIAnalysisResult

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("AI Analysis")
                    .font(AppTheme.gotu(28))
                    .padding(.top, 8)

                // Score card
                HStack(spacing: 18) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.primaryBlue.opacity(0.14))
                            .frame(width: 80, height: 80)
                        VStack(spacing: 1) {
                            Text("\(result.score)%")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(AppTheme.primaryBlue)
                            Text("Score")
                                .font(.system(size: 11))
                                .foregroundStyle(.gray)
                        }
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(result.headline)
                            .font(.system(size: 17, weight: .semibold))
                        Text(result.summary)
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                AnalysisSectionCard(icon: "checkmark.circle.fill", iconColor: .green,
                                    title: "Strengths", bullets: result.strengths)

                AnalysisSectionCard(icon: "arrow.up.circle.fill", iconColor: AppTheme.primaryBlue,
                                    title: "Room to Improve", bullets: result.improvements)

                AnalysisSectionCard(icon: "target", iconColor: .orange,
                                    title: "Next Steps", bullets: result.nextSteps)

                Spacer(minLength: 20)
            }
            .padding(24)
        }
    }
}

struct AnalysisSectionCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let bullets: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 8) {
                ForEach(bullets, id: \.self) { bullet in
                    HStack(alignment: .top, spacing: 10) {
                        Circle()
                            .fill(iconColor)
                            .frame(width: 6, height: 6)
                            .padding(.top, 6)
                        Text(bullet)
                            .font(.system(size: 15))
                            .foregroundStyle(.black.opacity(0.8))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
